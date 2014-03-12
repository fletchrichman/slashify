class CreateFaces < ActiveRecord::Migration
  def change
    create_table :faces do |t|
      t.integer :width
      t.integer :height
      t.integer :left
      t.integer :top
      t.integer :photo_id
    end
  end
end
