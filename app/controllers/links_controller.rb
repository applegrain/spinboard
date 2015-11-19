class LinksController < ApplicationController
  def index
    @user = current_user
    @links = current_user.links
  end

  def create
    link = Link.new(link_params)

    if link.save && Link.valid_url?(link_params[:url])
      @links = current_user.links << link
      redirect_to links_path
    else
      redirect_to links_path
      flash[:danger] = link.errors.full_messages.join(", ")
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
