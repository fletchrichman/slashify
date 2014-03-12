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

end
