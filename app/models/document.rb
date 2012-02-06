class Document < ActiveRecord::Base
	versioned

	has_many :document_contributors, :order => :id, :dependent => :destroy
	has_many :contributors, :through => :document_contributors, :uniq => true, :order => 'document_contributors.id ASC', :select => '"users".*, "document_contributors".*'

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

	def secure_id
		"a" + self.id.to_s + "-" + Digest::SHA1.hexdigest(self.id.to_s + MOBWRITE_SECRET_KEY)[0..7]
	end

	def body_redis_key
		"document:#{self.secure_id}:body"
	end

	def modified_redis_key
		"document:#{self.secure_id}:modified_at"
	end

	def contributors_redis_key
		"document:#{self.secure_id}:contributors"
	end

	def body
		REDIS.get(body_redis_key)
	end
end
