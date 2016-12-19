class LinksController < ApplicationController
  before_action :check_user
  def index
    @link = Link.new
    if current_user.links == nil
    else
      @links = current_user.links
    end
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.new( link_params )

    if @link.save
      flash[:notice] = "Link Created!"
      redirect_to links_path
    else
      flash[:danger] = "Link Invalid or not all Parameters created"
    end
  end

  def check_user
    unless current_user
      redirect_to login_router_path
    end
  end

  private
  def link_params
    params.require(:link).permit(:url, :title)
  end

end
