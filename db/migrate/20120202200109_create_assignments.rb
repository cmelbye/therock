class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :summary
      t.text :more_info
      t.date :due
      t.integer :status
      t.integer :assignor_id
      t.integer :assignee_id

      t.timestamps
    end
  end
end
