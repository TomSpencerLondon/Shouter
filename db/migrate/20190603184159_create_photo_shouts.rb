class CreatePhotoShouts < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_shouts do |t|
      t.attachment :image
    end
  end
end
