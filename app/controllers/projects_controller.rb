class ProjectsController < ApplicationController

  before_filter :authorize_admin!, :except =>[:index, :show]
  before_filter :authenticate_user!, :only => [:index, :show]
  before_filter :find_project, :only => [:show, :edit, :update, :destroy]

    def index
      @projects = Project.for(current_user).all
      #previously Project.all, now limited according to Permissions
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(params[:project])
      #passing the hashmap of submitted Project form params to Project.new
      if @project.save
        flash[:notice] = "Project has been created."
        redirect_to @project #rails uses 301 and keeps response objects, assumes 'show'
      else
        flash[:alert] = "Project has not been created."
        render :action => "new" #just showing the HTML for it, doesn't do controller logic
      end
    end

    def show
      @project = Project.find(params[:id])
      @tickets = @project.tickets
    end

    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      if @project.update_attributes(params[:project])
        flash[:notice] = "Project has been updated."
        redirect_to @project
      else
        flash[:alert] = "Project has not been updated."
        render :action => "edit"
      end
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      flash[:notice] = "Project has been deleted."
      redirect_to projects_path
    end

    private

    def find_project
      @project = Project.for(current_user).find(params[:id])

      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking" +
                      " for could not be found."
      redirect_to projects_path
    end
end
