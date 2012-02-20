class AddHeadlineToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :headline, :string
  end
end
