class Admin::BaseController < ApplicationController
  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: 'У вас нет прав для просмотра этой страницы' unless current_user.is_a?(Admin)
  end
end
