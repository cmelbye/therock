class Admin::UsersController < ApplicationController
  layout "people"
  
  def index
    @users = User.all
  end
end