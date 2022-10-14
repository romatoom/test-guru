class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    available_tests = Test.available
    @tests_count = available_tests.length

    @categories_count = available_tests.distinct.count(:category_id)
  end
end
