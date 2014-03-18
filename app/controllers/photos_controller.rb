class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id]).filtered_for_json
    session[:photo_id] = params[:id]
  end

  def create
    @photo = Photo.create(photo_params) 
    redirect_to root_url
  end

  def index
    @photos = Photo.all_filtered_for_json

    respond_to do |format|
      format.json {render json: @photos}
    end
  end


  private

  def photo_params
    params.require(:photo).permit(:uploaded_photo, :width, :height, :user_id)
  end
end
