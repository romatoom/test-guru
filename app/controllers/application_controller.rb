class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  def default_url_options
    { lang: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
        :email,
        :first_name,
        :last_name,
        :password)
    end
  end

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.admin?
        admin_tests_path
      else
        super
      end
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
