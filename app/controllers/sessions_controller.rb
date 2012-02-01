class SessionsController < ApplicationController
	def create
		auth_hash = request.env["omniauth.auth"].to_hash
		@user = User.find_or_create_by_id(auth_hash["uid"])
		@user.update_attributes(:name => auth_hash["info"]["name"], :first_name => auth_hash["info"]["first_name"], :last_name => auth_hash["info"]["last_name"], :icon => auth_hash["info"]["image"], :email => auth_hash["info"]["email"], :token => auth_hash["credentials"]["token"])
		session[:user_id] = @user.id
		render :text => @user.id
	end
end
