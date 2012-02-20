class FixPostColumns < ActiveRecord::Migration
  def up
  	change_column :posts, :published, :boolean, :default => true
  	add_column :posts, :body, :text
  end

  def down
  end
end
