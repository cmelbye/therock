# Represents a user in the database.
class User < ActiveRecord::Base
  # Returns an array of Document objects that the user is a contributor to.
	def documents
		document_ids = REDIS.smembers(self.class.documents_redis_key(self.id))

		Document.where(:id => document_ids)
	end
  
  # Returns the user's full name
	def name
		if first_name && last_name
			first_name + " " + last_name
		else
			"(unnamed staff member)"
		end
	end
  
  # Returns a hashed <tt>id</tt> representation that can be passed
  # to the MobWrite backend through the client. It's used so that the MobWrite
  # backend knows that the user is properly authenticated.
  #
  # It's hashed with a shared secret key so that the client can not
  # tamper with the <tt>id</tt>.
  #
  # It always begins with an "a" to fit within MobWrite's user
  # naming constraints.
  #
  # ==== Examples
  #  User.find(2).secure_id
  #  # => a2-0cc6c5ee
	def secure_id
		unless token
			set_new_token
		end

		"a" + self.id.to_s + "-" + Digest::SHA1.hexdigest(self.token + MOBWRITE_SECRET_KEY)[0..7]
	end
  
  # Returns the Redis key for the user's #token
	def token_redis_key
		"user:#{self.id}:token"
	end
  
  # Returns the user's token. The token is used to secure
  # communications between the client and the MobWrite daemon,
  # and prevents forgery. See #secure_id.
  #
  # If a token has not already been set, one will be generated automatically.
	def token
		t = REDIS.get(token_redis_key)
		unless t
			t = generate_token
			self.token = t
		end
		t
	end
  
  # Returns the Redis key for <tt>user_id</tt>'s documents.
	def self.documents_redis_key(user_id)
		"user:#{user_id}:documents"
	end
  
  # Sets the user's token to <tt>value</tt>.
	def token=(value)
		REDIS.set(token_redis_key, value)
	end
  
  # Returns a randomly generated security token.
  #
  # ==== Examples
  #  user.generate_token
  #  # => 96ba538a740e7fb044042364713fd794df41917d7edd0d1871b6269622aa3791
  #--
  # FIXME: turn this into a class method
	def generate_token
		Digest::SHA2.hexdigest(MOBWRITE_SECRET_KEY + self.id.to_s + Time.now.to_i.to_s)
	end
  
  # Returns all users in the format that the autocompleter form expects.
	def self.all_in_autocomplete
		self.all.map { |u| {:label => u.name, :value => u.id} }
	end
end
