class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      if cookies[:target_path].present?
        redirect_to cookies[:target_path], flash: { success: "Вы успешно вошли в систему" }
        cookies[:target_path] = nil
      else
        redirect_to root_path, flash: { success: "Вы успешно вошли в систему" }
      end
    else
      flash.now[:danger] = "Вы ввели неверные данные для входа"

      render :new
    end
  end

  def destroy
    # session.delete(:user_id) - или так правильней?
    session[:user_id] = nil

    redirect_to root_path, flash: { success: "Вы успешно вышли из системы" }
  end
end
