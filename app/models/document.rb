# Represents a document in the database.
class Document < ActiveRecord::Base
	versioned

	has_one :post

	after_destroy :destroy_redis_keys
  
  # Returns a pretty list of contributors. The format of the list
  # changes depending on the number of contributors in order
  # to keep the list compact. It's useful in tabular representations
  # of documents.
  #
  # ==== Examples
  # If there's only one contributor, it'll return the contributor's full name:
  #
  #  document.pretty_contributors
  #  # => John Doe
  #
  # If there are two contributors, both of their first names will be listed:
  #
  #  document.pretty_contributors
  #  # => John and Kate
  #
  # If there are more than two contributors, the first two contributors' first
  # names will be listed, and it will mention that there are other contributors
  # that weren't listed (in order to keep the list compact)
  #
  #  document.pretty_contributors
  #  # => John, Kate, and 2 others
  
	def pretty_contributors
		output = ""

		case self.contributors.size
		when 0
			output = "(none yet)"
		when 1
			output = self.contributors.first.name
		when 2
			output = self.contributors.map { |c| c.first_name }.join(' and ')
		else
			output = self.contributors.first(2).map { |c| c.first_name }.join(', ')

			others = self.contributors.size - 2

			if others == 1
				output += ", and one other"
			else
				output += ", and #{others} others"
			end
		end

		output
	end
  
  # Returns an array of the document's contributors, sorted by
  # when the contributor was added to the document ascending.
	def contributors
		contributor_ids = REDIS.zrange(contributors_redis_key, 0, -1)

		sorter = Hash[contributor_ids.map(&:to_i).each_with_index.to_a]

		User.where(:id => contributor_ids).all.sort_by { |u| sorter[u.id] }
	end
  
  # Adds a contributor to the document's list of contributors.
  #
  # <tt>who</tt> can either be an integer value containing the
  # <tt>id</tt> attribute of the User to be added to the list, or
  # it can simply be a User object.
  #
  # The method will return <tt>false</tt> if the contributor is already
  # on the list, unless <tt>force</tt> is set to <tt>true</tt>.
  #
  # ==== Examples
  # This method can add a user to the list by passing the User <tt>id<tt> attribute
  #
  #  document.add_contributor! 5
  #  # => true
  #
  # Or, it can add a user by passing the User object itself
  #
  #  document.add_contributor! User.find_by_email('john@doe.com')
  #  # => true
  #
  # Finally, the force flag can be used to add a contributor that's already on the list:
  #
  #  document.add_contributor! 1         # => true
  #  document.add_contributor! 1         # => false
  #  document.add_contributor! 1, true   # => true
	def add_contributor!(who, force=false)
		if who.is_a? Integer
			user_id = who
		elsif who.is_a? User
			user_id = who.id
		else
			return false
		end

		if REDIS.zscore(contributors_redis_key, user_id) && !force
			return false
		else
			REDIS.multi do
				REDIS.zadd(contributors_redis_key, Time.now.to_i, user_id)
				REDIS.sadd(User.documents_redis_key(user_id), self.id)
			end
			return true
		end
	end
  
  # Returns a hashed <tt>id</tt> representation that can be passed
  # to the MobWrite backend through the client. It's used so that the MobWrite
  # backend knows where to save the document in the database.
  #
  # It's hashed with a shared secret key so that the client can not
  # tamper with the <tt>id</tt>.
  #
  # It always begins with an "a" to fit within MobWrite's document
  # naming constraints.
  #
  # ==== Examples
  #  Document.find(1).secure_id
  #  # => a1-0b5ca2de
	def secure_id
		"a" + self.id.to_s + "-" + Digest::SHA1.hexdigest(self.id.to_s + MOBWRITE_SECRET_KEY)[0..7]
	end
  
  # Returns a Time representation of when the
  # document was last modified.
	def modified_at
		Time.at(REDIS.get(modified_redis_key).to_i)
	end
  
  # Returns the Redis key for the document body.
	def body_redis_key
		"document:#{self.secure_id}:body"
	end
  
  # Returns the Redis key for the
  # last modified timestamp.
	def modified_redis_key
		"document:#{self.secure_id}:body:modified_at"
	end
  
  # Returns the Redis key for the contributors
  # sorted set.
	def contributors_redis_key
		"document:#{self.secure_id}:contributors"
	end
  
  # Returns the document's body text.
  # 
  # ==== Examples
  #  document.body
  #  # => Lorum ipsum dolor sit amet...
	def body
		REDIS.get(body_redis_key)
	end
  
  private
	def destroy_redis_keys
		# Remove document from My Documents lists of contributors
		REDIS.zrange(self.contributors_redis_key, 0, -1).each do |uid|
			REDIS.srem(User.documents_redis_key(uid), self.id)
		end

		# Remove our keys
		REDIS.multi do
			REDIS.rem(self.body_redis_key)
			REDIS.rem(self.modified_redis_key)
			REDIS.rem(self.contributors_redis_key)
		end
	end
end
