class TasklistController < ApplicationController
  
  def index
    @tasklists = Task.all
  end
  
  def create
    @tasklist = Task.new(task_params)
    
    if @tasklist.save
      flash[:success] = "タスクが正常に登録されました"
      redirect_to tasklist_path(@tasklist.id)
    else
      flash.now[:danger] = "タスクが登録されませんでした"
      render :new
    end
  end
  
  def new
    @tasklist = Task.new
  end
  
  def edit
    @tasklist = Task.find(params[:id])
  end
  
  def show
    @tasklist = Task.find(params[:id])
  end
  
  def update
    @tasklist = Task.find(params[:id])
    
    if @tasklist.update(task_params)
      flash[:success] = "タスクが正常に変更されました"
      redirect_to tasklist_path(@tasklist)
    else
      flash.now[:danger] = "タスクが変更されませんでした"
      render :edit
    end    
  end
  
  def destroy
    @tasklist = Task.find(params[:id])
    @tasklist.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to ("/")
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content)
  end  
  
end
