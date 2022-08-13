class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to tests_path, flash: { success: "Вы успешно вошли в систему" }
    else
      flash.now[:danger] = "Вы ввели неверные данные для входа"

      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, flash: { success: "Вы успешно вышли из системы" }
  end
end
