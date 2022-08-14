class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_user,
                :logged_in?

  private

  def authenticate_user!
    unless current_user
      cookies[:target_path] = request.original_fullpath
      redirect_to login_path, flash: { warning: 'Вы не вошли в систему. Пожалуйста, введите свой email и пароль' }
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
