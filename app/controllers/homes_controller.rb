class HomesController < ApplicationController
  def show
    @repos = if params[:username]
               Octokit::Client.new.repositories(params[:username])
             else
               []
             end
  end
end
