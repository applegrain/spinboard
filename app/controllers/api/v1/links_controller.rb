class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    respond_with Link.where(user_id: current_user.id)
  end

  def update
    respond_with Link.find(params[:id]).update(status: params[:link][:status])
  end
end
