class User < ApplicationRecord
  has_many :user_tests

  def tests_by_level(level)
    Test.joins(:users_tests).where(users_tests: { user_id: id }, level: level)
  end
end
