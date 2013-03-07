class ProjectsController < ApplicationController

    def index
      binding.pry
      @projects = Project.all
      #respond_to do |format|
      #  format.HTML
      #  format.json { render @projects.to_json }
      #end
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
    end
end
