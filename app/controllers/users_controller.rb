class UsersController < ApplicationController
  # before_action :not_login_user?, only:[:show]

  def new
    redirect_to tasks_path if logged_in?
    @user = User.new
  end

  def create
    @usr = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
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
      params.require(:user).permit(:name, :email, :password, :password_digest)
    end
end
