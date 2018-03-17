class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #@tasks = current_user.try!(:tasks).try!(:page, params[:page])
    @tasks = current_user.tasks.page(params[:page]) if logged_in?
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に登録されました"
      redirect_to task_path(@task.id)
    else
      flash.now[:danger] = "タスクが登録されませんでした"
      render :new
    end
  end
  
  def new
    @task = Task.new
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクが正常に変更されました"
      redirect_to task_path(@task)
    else
      flash.now[:danger] = "タスクが変更されませんでした"
      render :edit
    end    
  end
  
  def destroy
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to ("/")
  end
  
  private

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end    
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end  
  
end
