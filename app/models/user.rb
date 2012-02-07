class User < ActiveRecord::Base
	def documents
		document_ids = REDIS.smembers(self.class.documents_redis_key(self.id))

		Document.where(:id => document_ids).order("updated_at DESC")
	end

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

	def self.documents_redis_key(k_id)
		"user:#{k_id}:documents"
	end

	def token=(value)
		REDIS.set(token_redis_key, value)
	end

	def generate_token
		Digest::SHA2.hexdigest(MOBWRITE_SECRET_KEY + self.id.to_s + Time.now.to_i.to_s)
	end
end
