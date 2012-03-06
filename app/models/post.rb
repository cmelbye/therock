# Represents a post in the database.
class Post < ActiveRecord::Base
	belongs_to :document

	before_save :update_body

	private
	def update_body
		doc = Document.find(self.document_id)
		self.body = doc.body
		self.headline = doc.name
	end
end
