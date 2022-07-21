class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :users_tests
  has_many :users, through: :users_tests

  class << self
    def tests_by_category_desc(category_title)
      category = Category.find_by(title: category_title)
      category.nil? ? [] : category.tests.order(title: :desc).pluck(:title)
    end
  end
end
