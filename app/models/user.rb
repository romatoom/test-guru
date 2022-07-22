class User < ApplicationRecord
  has_many :users_tests
  has_many :tests, through: :users_tests
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  scope :tests_for_user_by_level, ->(user, level) { user.tests.where(level: level) }

  def tests_by_level(level)
    User.tests_for_user_by_level(self, level)
  end
end
