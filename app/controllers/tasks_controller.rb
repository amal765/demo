class TasksController < ApplicationController
  def create
    @task= Task.new(task_params)
    @task.group_id = params[ :id]
    if @task.save
      flash[:info] = "Task Assigned Successfully"
    else
      flash[:info] = "Error!"
    end
  end
  def update

    @task = Task.find(params[:id])
    if @task.status == "pending"
      @task.update_attribute(:status, "started")
    else
      @task.update_attribute(:status, "Completed")
    end
    redirect_to group_path(@task.group_id)

  end
  private

    def task_params
      params.require(:task).permit(:name, :status, :duration, :user_id, :group_id)
    end
end
