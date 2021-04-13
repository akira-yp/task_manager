class TasksController < ApplicationController
  before_action :check_login
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :check_login, only:[:index]

  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = current_user.tasks.search_title(params[:task][:title]).search_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:title].present?
        @tasks = current_user.tasks.search_title(params[:task][:title]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = current_user.tasks.search_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:tag].present?
        @tasks = current_user.tasks.search_tag(params[:task][:tag]).page(params[:page])
      else
        @tasks = current_user.tasks.select(:id, :title, :content, :created_at,:status,:priority,:expired_at).order(created_at: :DESC).page(params[:page])
      end
    else
      if params[:sort_expired]
        @tasks = current_user.tasks.select(:id, :title, :content, :created_at,:status,:priority,:expired_at).order(expired_at: :ASC).page(params[:page])
      elsif params[:sort_priority]
        @tasks = current_user.tasks.select(:id, :title, :content, :created_at,:status,:priority,:expired_at).order(priority: :ASC).page(params[:page])
      else
        @tasks = current_user.tasks.includes(:tags).all.order(created_at: :DESC).page(params[:page])
      end
    end
  end

  def show
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "新しいタスクを追加しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク内容を変更しました"
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: "タスクを削除しました"
    else
      render :index
    end
  end

  private
  def set_task
    @task = current_user.tasks.includes(:tags).find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, {tag_ids:[]})
  end
  #
  # def check_login
  #   redirect_to new_session_path unless logged_in?
  # end
end
