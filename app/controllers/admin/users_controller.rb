class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only:[:edit, :update, :destroy]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path,notice:"ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      render :index
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      redirect_to root_url unless current_user.admin?
    end
end
