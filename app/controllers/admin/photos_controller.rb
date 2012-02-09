class Admin::PhotosController < ApplicationController
	layout "photos"
	before_filter :find_photoset

	def index
		
	end

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

	protected
	def find_photoset
		@photoset = Photoset.find(params[:photoset_id])
	end
end