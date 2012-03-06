# Controller that facilitates the publishing of documents through Post objects
class Admin::PostsController < ApplicationController
	layout "documents"
	before_filter :find_document

  # If the document has been posted, redirect to the edit publish options page. If
  # not, redirect to the publish page.
	def show
		@post = @document.post

		if @post
			redirect_to edit_admin_document_post_path(@document)
		else
			redirect_to new_admin_document_post_path(@document)
		end
	end

  # Shows publish options for documents that haven't been published yet
	def new
		@post = @document.build_post
	end
  
  # Allows the user to edit publish options after the Post has already been created
	def edit
		@post = @document.post
	end
  
  # Publishes the Document by creating its Post object
	def create
		@post = @document.build_post(params[:post])

		if @post.save
			redirect_to admin_document_path(@document), notice: '<strong>Awesome!</strong> The document has been published.'
		else
			render action: "new"
		end
	end

  # Updates publish options
	def update
		@post = @document.post

		if @post.update_attributes(params[:post])
			redirect_to admin_document_path(@document), notice: '<strong>Awesome!</strong> The post has been updated.'
		else
			render action: "edit"
		end
	end

	private
	def find_document
		@document ||= Document.find(params[:document_id])
	end
end