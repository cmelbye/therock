class CreateDocumentContributors < ActiveRecord::Migration
  def change
    create_table :document_contributors do |t|
      t.integer :document_id
      t.integer :contributor_id

      t.timestamps
    end
  end
end
