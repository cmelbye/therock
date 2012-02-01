class ChangeUsersIdColumn < ActiveRecord::Migration
  def up
		change_column :users, :id, 'bigint'
  end

  def down
  end
end
