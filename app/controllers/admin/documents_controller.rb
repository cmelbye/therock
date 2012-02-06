class Admin::DocumentsController < ApplicationController
  layout "documents"

  # GET /documents
  # GET /documents.json
  def index
    @documents = current_user.documents.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  def all
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    render :layout => "admin"
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document].merge({:updated_by => current_user}))

    respond_to do |format|
      if @document.save
        @document.contributors << current_user
        format.html { redirect_to edit_admin_document_path(@document), notice: '<strong>Awesome!</strong> The document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document].merge({:updated_by => current_user}))
        unless @document.document_contributors.find_by_contributor_id(current_user.id)
          @document.contributors << current_user
        end
        format.html { redirect_to edit_admin_document_path(@document), notice: '<strong>Success!</strong> The document was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to admin_documents_url }
      format.json { head :ok }
    end
  end
end
