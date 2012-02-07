class Document < ActiveRecord::Base
	versioned

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

	def contributors
		contributor_ids = REDIS.zrange(contributors_redis_key, 0, -1)

		sorter = Hash[contributor_ids.map(&:to_i).each_with_index.to_a]

		User.where(:id => contributor_ids).all.sort_by { |u| map[u.id] }
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
