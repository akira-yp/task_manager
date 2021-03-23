class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.search_title(params[:task][:title]).search_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = Task.search_title(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = Task.search_status(params[:task][:status])
      end
    elsif params[:sort_expired]
      @tasks = Task.all.order(expired_at: :DESC)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :ASC)
    else
      @tasks = Task.all.order(created_at: :DESC)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
      renser :index
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
