class LinksController < ApplicationController
  def index
    unless current_user
      redirect_to login_router_path
    end
  end

end
