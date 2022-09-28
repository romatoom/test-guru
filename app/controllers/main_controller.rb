class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    available_tests = Test.available
    @tests_count = available_tests.length

    available_categories = []
    available_tests.each do |test|
      available_categories << test.category.title
    end

    @categories_count = available_categories.uniq.length
  end
end
