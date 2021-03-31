class SessionsController < ApplicationController

  def new
    redirect_to tasks_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_users_path
      else
        redirect_to tasks_path
      end
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
