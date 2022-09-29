class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    available_tests = Test.available
    @tests_count = available_tests.length

    categories_of_tests_available = available_tests.map { |t| t.category.title }
    @categories_count = categories_of_tests_available.uniq.length
  end
end
