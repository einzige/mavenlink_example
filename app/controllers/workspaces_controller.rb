class WorkspacesController < ApplicationController
  before :show, :load_workspace!

  def index
    @workspaces = Mavenlink::Workspace.all
    json_render
  end

  def show
    json_render
  end

  def create
    @workspace = Mavenlink::Workspace.new(params[:workspace])

    if @workspace.save
      json_reload
    else
      json_render_errors @workspace.errors
    end
  end

  private

  def load_workspace!
    @workspace = Mavenlink::Workspace.find(params[:id]) or error(404)
  end
end