# encoding: utf-8

# Uploads photos to Amazon S3.
class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  # Returns the path to where uploads are stored in S3.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  version :thumb do
    process :resize_to_fill => [210,145]
  end
  
  # Returns an array of extensions that are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
