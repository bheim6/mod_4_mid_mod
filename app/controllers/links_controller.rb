class LinksController < ApplicationController
  def index
    unless current_user
      redirect_to login_router_path
    end

    @link = Link.new
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new( link_params )

    if @link.save
      @link.user_id = current_user.id
      flash[:notice] = "Link Created!"
      redirect_to links_path
    else
      flash[:danger] = "Link Invalid or not all Parameters created"
    end
  end

  private
  def link_params
    params.require(:link).permit(:url,
                                 :title)
  end

end
