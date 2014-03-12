class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_url
      t.integer :width
      t.integer :height
      t.string :filter
      t.integer :user_id

      t.timestamps
    end
  end
end
