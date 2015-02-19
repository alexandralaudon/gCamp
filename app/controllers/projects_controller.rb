class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.save
    redirect_to project_path(@project), notice: "Project was successfully created"
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

private

  def project_params
    params.require(:project).permit(:name, :created_at, :updated_at)
  end

end