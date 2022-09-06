class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @tests_count = Test.count
    @categories_count = Category.count
  end
end
