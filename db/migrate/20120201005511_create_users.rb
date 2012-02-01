class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
			t.string :uid
      t.string :name
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :icon
      t.string :token

      t.timestamps
    end
  end
end
