class TasksController < ApplicationController
  before_filter :load_workspace!
  before_filter :load_task!, only: [:edit, :update, :destroy]

  def index
    @tasks = Mavenlink::Story.filter(workspace_id: @workspace.id).
                              page(params[:page]).
                              per_page(5)
    json_render
  end

  def new
    json_render
  end

  def create
    @task = Mavenlink::Story.new(params[:task])

    if @task.save
      json_reload
    else
      json_render_errors @task.errors
    end
  end

  def edit
    json_render
  end

  def update
    if @task.update_attributes(params[:task])
      json_redirect workspace_path(@workspace.id)
    else
      json_render_errors @task.errors
    end
  end

  def destroy
    @task.destroy
    json_reload
  end

  private

  def load_task!
    @task = Mavenlink::Story.find(params[:id]) or error(404)
  end

  def load_workspace!
    @workspace = Mavenlink::Workspace.find(params[:workspace_id]) or error(404)
  end
end