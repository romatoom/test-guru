class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :users_tests, dependent: :destroy
  has_many :tests, through: :users_tests
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  # validates :email, presence: true,
  #                   uniqueness: true,
  #                   format: { with: URI::MailTo::EMAIL_REGEXP }

  # validates :name, presence: true

  def tests_by_level(level)
    tests.where(level: level)
  end

  def user_test(test)
    users_tests.order(id: :desc).find_by(test_id: test.id)
  end
end
