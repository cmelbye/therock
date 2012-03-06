# Represents a photoset in the database.
class Photoset < ActiveRecord::Base
	has_many :photos
end
