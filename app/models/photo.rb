# Represents a photo in the database, and mounts the photo uploader.
class Photo < ActiveRecord::Base
	mount_uploader :photo, PhotoUploader
	belongs_to :photoset
end
