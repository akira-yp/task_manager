class Admin::UsersController < ApplicationController
  before_action :check_login
  before_action :require_admin
  before_action :set_user, only:[:show, :edit, :update, :destroy]


  def index
    @users = User.all.includes(:tasks).order(created_at: :DESC)
  end

  def show
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
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path,notice:"ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @user.id
      redirect_to admin_users_path
    else
      if @user.destroy
        redirect_to admin_users_path, notice: "ユーザーを削除しました"
      else
        render :index
      end
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
      unless current_user.admin?
      redirect_to tasks_path
      flash[:notice] = '管理者以外はアクセスを許可されていません'
      end
    end
end
