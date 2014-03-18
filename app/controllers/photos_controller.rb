class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
    @photo_with_faces = @photo.filtered_for_json
    session[:photo_id] = params[:id]
  end

  def create
    @photo = Photo.create(photo_params)
    @photo.photo_url = @photo.uploaded_photo.url
    @photo.width = @photo.uploaded_photo.geometry[:width] 
    @photo.height = @photo.uploaded_photo.geometry[:height] 
    @photo.save
    @photoservice = PhotoService.new
    @photoservice.download_and_process(@photo)
    redirect_to photo_path(@photo)
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
