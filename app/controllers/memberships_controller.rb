class MembershipsController < ApplicationController
  before_action :require_login

  def index
    @project = Project.find(params[:project_id])
    @membership = Membership.new
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new(membership_params)
    # @membership = Membership.new(membership_params.merge(project_id: params[:project_id]))
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    Membership.find(params[:id]).destroy
    redirect_to project_memberships_path
  end

  private

  def membership_params
    params.require(:membership).permit(:project_id, :user_id, :role)
  end
end
