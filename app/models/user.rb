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

  has_many :users_badges, dependent: :destroy
  has_many :badges, through: :users_badges

  validates :first_name, presence: true
  validates :last_name, presence: true

  def tests_by_level(level)
    tests.where(level: level)
  end

  def user_test(test)
    users_tests.order(id: :desc).find_by(test_id: test.id)
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def admin?
    type == "Admin"
  end
end
