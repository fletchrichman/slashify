class AddFinalUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :final_url, :string
  end
end
