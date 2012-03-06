# Controller that manages uploading and editing of individual Photo objects.
class Admin::PhotosController < ApplicationController
	layout "photos"
	before_filter :find_photoset
  before_filter :login_required
  
  # Creates a new Photo and adds it to the <tt>params[:photoset_id]</tt> Photoset.
  #
  # The uploading of the photo is handled by the mounted PhotoUploader.
	def create
		@photo = @photoset.photos.build(params[:photo])
	    respond_to do |format|
	      if @photo.save
	        format.html { redirect_to [:admin, @photoset], notice: 'Photo was successfully upload.' }
	        format.json { render json: @photo, status: :created, location: [:admin, @photoset] }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @photo.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private
	def find_photoset
		@photoset = Photoset.find(params[:photoset_id])
	end
end