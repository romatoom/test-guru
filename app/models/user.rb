class User < ApplicationRecord
  has_many :users_tests, dependent: :destroy
  has_many :tests, through: :users_tests
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  validates :email, presence: true
  validates :name, presence: true

  def tests_by_level(level)
    tests.where(level: level)
  end

  def user_test(test)
    users_tests.order(id: :desc).find_by(test_id: test.id)
  end
end
