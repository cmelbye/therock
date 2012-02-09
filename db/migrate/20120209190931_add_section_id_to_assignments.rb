class AddSectionIdToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :section_id, :integer
  end
end
