class User < ActiveRecord::Base
	has_many :document_contributors, :foreign_key => "contributor_id"
	has_many :documents, :through => :document_contributors, :uniq => true, :order => 'documents.updated_at DESC'
end
