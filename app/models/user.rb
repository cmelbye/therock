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

	def secure_id
		unless token
			set_new_token
		end

		"a" + self.id.to_s + "-" + Digest::SHA1.hexdigest(self.token + MOBWRITE_SECRET_KEY)[0..7]
	end

	def token_redis_key
		"user:#{self.id}:token"
	end

	def token
		t = REDIS.get(token_redis_key)
		unless t
			t = generate_token
			self.token = t
		end
		t
	end

	def token=(value)
		REDIS.set(token_redis_key, value)
	end

	def generate_token
		Digest::SHA2.hexdigest(MOBWRITE_SECRET_KEY + self.id.to_s + Time.now.to_i.to_s)
	end
end
