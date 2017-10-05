class TasksController < ApplicationController
  def create
    @task= Task.new(task_params)
    respond_to do |format|
      if @task.save
        flash[:info] = "Task Assigned Successfully"
        format.js
      else
        format.js {render 'task_error.js.erb'}
      end
    end
  end
  def update
    @task = Task.find(params[:id])
    if @task.status == "pending"
      @task.update(status: "started")
    else
      @task.update(status: "Completed")
    end
    redirect_to group_path(@task.group_id)
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :duration, :user_id, :group_id)
  end

end
