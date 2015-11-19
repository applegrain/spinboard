class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    respond_with Link.where(user_id: current_user.id)
  end

  def update
    respond_with Link.find(params[:id]).update(status: params[:link][:status])
  end

  def edit
    respond_with is_valid_link?
  end

  private

  def is_valid_link?
    url = params[:link][:url]
    if Link.valid_url?(url)
      Link.find(params[:id]).update(link_params)
    else
      flash[:danger] = "Please submit a valid URL."
    end
  end

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
