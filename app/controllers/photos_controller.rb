class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])

    @photo_json = @photo.as_json
    @photo_json["faces"] = @photo.faces.as_json

    respond_to do |format|
      format.html
      format.js { render @photo_json.to_json }
    end
  end

  def index
    @photos = Photo.all_filtered_for_json

    respond_to do |format|
      format.json {render json: @photos}
    end
  end
end
