class AddUploadedPhotoToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :uploaded_photo, :string
  end
end
