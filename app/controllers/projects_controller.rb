class ProjectsController < ApplicationController
  def index
    @featured = Project.featured
    @minor = Project.minor
  end

  def show
    @project = Project.find(params[:id])

    render :not_found, status: :not_found if @project.nil?
  end
end
