class Photo < ActiveRecord::Base
	mount_uploader :photo, PhotoUploader
	belongs_to :photoset
end
