# Controller for the Assignment manager.
class Admin::AssignmentsController < ApplicationController
  layout "assignments"
  before_filter :login_required


  # Finds all Assignment objects that are assigned to the current user.
  def index
    @assignments = Assignment.find_all_by_assignee_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # Finds all Assignment objects.
  def all
    @assignments = Assignment.all

    respond_to do |format|
      format.html # to.html.erb
      format.json { render json: @assignments }
    end
  end

  # Finds all Assignment objects that are assigned by the current user.
  def by_me
    @assignments = Assignment.find_all_by_assignor_id(current_user.id)

    respond_to do |format|
      format.html # by.html.erb
      format.json { render json: @assignments }
    end
  end

  # Finds an Assignment as provided by the <tt>params[:id]</tt> parameter.
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # Creates a blank Assignment object.
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # Finds an Assignment object as determined by the <tt>params[:id]</tt> parameter so that it may be edited.
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # Creates an Assignment object using the <tt>params[:assignment]</tt> parameter as the object attributes.
  def create
    @assignment = Assignment.new(params[:assignment])

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to [:admin, @assignment], notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # Updates an Assignment object with the <tt>params[:assignment]</tt> attributes.
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to [:admin, @assignment], notice: 'Assignment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # Destroys an Assignment by removing it from the database.
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to admin_assignments_url }
      format.json { head :ok }
    end
  end
end
