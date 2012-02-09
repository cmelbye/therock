class CreatePhotosets < ActiveRecord::Migration
  def change
    create_table :photosets do |t|
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
