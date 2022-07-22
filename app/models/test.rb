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

  scope :tests_titles_by_category_title_desc, ->(category_title) do
    category = Category.find_by(title: category_title)
    return [] if category.nil?
    where(category_id: category.id).order(title: :desc).pluck(:title)
  end
end
