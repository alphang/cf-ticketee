class ProjectsController < ApplicationController

    def index
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(params[:project])
      #passing the hashmap of submitted Project form params to Project.new
      if @project.save
        flash[:notice] = "Project has been created."
        redirect_to @project
      else
        flash[:alert] = "Project has not been created."
        render :action => "new"
      end
    end

    def show
      @project = Project.find(params[:id])
    end
end