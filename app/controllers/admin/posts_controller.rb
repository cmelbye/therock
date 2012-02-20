class Admin::PostsController < ApplicationController
	layout "documents"
	before_filter :find_document

	def show
		@post = @document.post

		if @post
			redirect_to edit_admin_document_post_path(@document)
		else
			redirect_to new_admin_document_post_path(@document)
		end
	end

	def new
		@post = @document.build_post
	end

	def edit
		@post = @document.post
	end

	def create
		@post = @document.build_post(params[:post])

		if @post.save
			redirect_to admin_document_path(@document), notice: '<strong>Awesome!</strong> The document has been published.'
		else
			render action: "new"
		end
	end

	def update
		@post = @document.post

		if @post.update_attributes(params[:post])
			redirect_to admin_document_path(@document), notice: '<strong>Awesome!</strong> The post has been updated.'
		else
			render action: "edit"
		end
	end

	protected
	def find_document
		@document ||= Document.find(params[:document_id])
	end
end