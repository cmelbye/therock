class Document < ActiveRecord::Base
	versioned

	has_many :document_contributors, :order => :id
	has_many :contributors, :through => :document_contributors, :uniq => true, :order => 'document_contributors.id ASC'

	def pretty_contributors
		output = ""

		case self.contributors.size
		when 1
			output = self.contributors.first.name
		when 2
			output = self.contributors.all.map { |c| c.first_name }.join(' and ')
		else
			output = self.contributors.limit(2).all.map { |c| c.first_name }.join(', ')

			others = self.contributors.size - 2

			if others == 1
				output += ", and one other"
			else
				output += ", and #{others} others"
			end
		end

		output
	end
end
