class Admin::PhotosetsController < ApplicationController
  layout "photosets"
  before_filter :login_required

  
  # GET /photosets
  # GET /photosets.json
  def index
    @photosets = Photoset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photosets }
    end
  end

  # GET /photosets/1
  # GET /photosets/1.json
  def show
    @photoset = Photoset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photoset }
    end
  end

  # GET /photosets/new
  # GET /photosets/new.json
  def new
    @photoset = Photoset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photoset }
    end
  end

  # GET /photosets/1/edit
  def edit
    @photoset = Photoset.find(params[:id])
  end

  # POST /photosets
  # POST /photosets.json
  def create
    @photoset = Photoset.new(params[:photoset])

    respond_to do |format|
      if @photoset.save
        format.html { redirect_to [:admin, @photoset], notice: 'Photoset was successfully created.' }
        format.json { render json: @photoset, status: :created, location: @photoset }
      else
        format.html { render action: "new" }
        format.json { render json: @photoset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photosets/1
  # PUT /photosets/1.json
  def update
    @photoset = Photoset.find(params[:id])

    respond_to do |format|
      if @photoset.update_attributes(params[:photoset])
        format.html { redirect_to [:admin, @photoset], notice: 'Photoset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @photoset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photosets/1
  # DELETE /photosets/1.json
  def destroy
    @photoset = Photoset.find(params[:id])
    @photoset.destroy

    respond_to do |format|
      format.html { redirect_to admin_photosets_url }
      format.json { head :ok }
    end
  end
end
