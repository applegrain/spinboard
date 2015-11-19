class LinksController < ApplicationController
  def index
    @user = current_user
    @links = current_user.links
  end

  def create
    if Link.valid_url?(link_params[:url])
      link = Link.create(link_params)
      # why do I have to add the link manually?
      @links = current_user.links << link
      redirect_to links_path
    else
      redirect_to links_path
      flash[:danger] = "Invalid URL."
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
