class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :users_tests

  class << self
    def tests_by_category_desc(category_title)
      Test.joins(:category)
        .where({ category: { title: category_title } })
        .order(title: :desc)
        .pluck(:title)
    end
  end
end
