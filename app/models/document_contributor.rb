# Represents a document contributor in the database.
class DocumentContributor < ActiveRecord::Base
	belongs_to :document
	belongs_to :contributor, :class_name => "User"
end
