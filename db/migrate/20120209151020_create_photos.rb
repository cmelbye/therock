class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :caption
      t.string :photo
      t.integer :photoset_id
      t.integer :user_id

      t.timestamps
    end
  end
end
