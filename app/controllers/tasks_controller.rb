class TasksController < ApplicationController
  
  def index
    @tasks = Task.all.page(params[:page])
  end
  
  def create
    @task = Task.new(task_params)
    
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
    set_task
  end
  
  def show
    set_task
  end
  
  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = "タスクが正常に変更されました"
      redirect_to task_path(@task)
    else
      flash.now[:danger] = "タスクが変更されませんでした"
      render :edit
    end    
  end
  
  def destroy
    set_task
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to ("/")
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end  
  
end
