class User < ActiveRecord::Base
	has_many :document_contributors, :foreign_key => "contributor_id", :dependent => :destroy
	has_many :documents, :through => :document_contributors, :uniq => true, :order => 'documents.updated_at DESC'

	def name
		if first_name && last_name
			first_name + " " + last_name
		else
			"(unnamed staff member)"
		end
	end
end
