class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :users_tests
  has_many :users, through: :users_tests
  belongs_to :author, class_name: "User", foreign_key: "author_id"

  DIFFICULTY_LEVELS = %i(easy medium hard)

  DIFFICULTY_LEVEL_RANGES = {
    easy: 0..1,
    medium: 2..4,
    hard: 5..Float::INFINITY
  }

  scope :tests_by_difficulty!, ->(difficulty) do
    difficulty = difficulty.downcase.to_sym
    raise "Unsupported difficulty level value" unless DIFFICULTY_LEVELS.include?(difficulty)

    where(level: DIFFICULTY_LEVEL_RANGES[difficulty])
  end

  scope :tests_by_category_id, ->(category_id) { where(category_id: category_id) }

  validates :title, presence: true,
                    uniqueness: { scope: :level, message: "There can only be one test with this title and level" }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  class << self
    def tests_titles_by_category_title_desc(category_title)
      category = Category.find_by(title: category_title)
      return [] if category.nil?
      tests_by_category_id(category.id).order(title: :desc).pluck(:title)
    end
  end
end
