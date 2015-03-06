class TasksController < ApplicationController
  before_action :require_login

  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "Task was successfully created!"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    @project = @task.project
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    task_params = params.require(:task).permit(:description, :complete, :due_date)
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "Task was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to tasks_path, notice: "Task was successfully deleted!"
  end


  private

  def task_params
    params.require(:task).permit(:description, :complete, :due_date, :project_id)
  end

end
