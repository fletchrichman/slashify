class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id]).filtered_for_json
    session[:photo_id] = params[:id]
  end

  def create
    @photo = Photo.new(params[:photo])
  end

  def index
    @photos = Photo.all_filtered_for_json

    respond_to do |format|
      format.json {render json: @photos}
    end
  end
end
