# Controller for the user directory and user profile
class Admin::UsersController < ApplicationController
  layout "people"
  before_filter :login_required
  
  # Finds all User objects
  def index
    @users = User.all
  end
  
  # Finds a User so that their profile can be displayed
  def show
  	@user = User.find(params[:id])
  end
  
  # Finds the current user's User object so that they may edit their profile
  def edit
  	@user = current_user
  end
  
  # Updates the current user's User object attributes
  def update
  	@user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(current_user), notice: '<strong>Success!</strong> Your profile was updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end