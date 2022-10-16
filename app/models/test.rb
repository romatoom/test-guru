class Test < ApplicationRecord
  extend Converter::Time

  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :users_tests, dependent: :destroy
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

  scope :tests_by_category_title, ->(category_title) { joins(:category).where(category: { title: category_title}) }

  scope :available, -> { where(published: true).where("questions_count > ?", 0) }

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  class << self
    def tests_titles_by_category_title_desc(category_title)
      tests_by_category_title(category_title).order(title: :desc).pluck(:title)
    end
  end

  def time_test?
    time_to_pass != "00:00:00"
  end

  def time_to_pass_in_seconds
    Test.hms_to_seconds(time_to_pass)
  end
end
