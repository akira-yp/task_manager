class UsersController < ApplicationController
  # before_action :not_login_user?, only:[:show]

  def new
    redirect_to tasks_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice:"新規ユーザー登録しました"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    not_login_user?
  end

   private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
