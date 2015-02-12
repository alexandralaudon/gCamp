class TasksController < ApplicationController
    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      @task.save
      redirect_to task_path(@task), notice: "Task was successfully created!"
    end

    def show
      @task = Task.find(params[:id])
    end

    def edit
      @task = Task.find(params[:id])
      @complete = "Completed!"
    end

    def update
      @task = Task.find(params[:id])
      task_params = params.require(:task).permit(:description)
      if @task.update(task_params)
        redirect_to task_path(@task), notice: "Task was successfully updated!"
      end
    end

    def destroy
      Task.find(params[:id]).destroy
      redirect_to tasks_path, notice: "Task was successfully deleted!"
    end


    private

    def task_params
      params.require(:task).permit(:description)
    end

end
