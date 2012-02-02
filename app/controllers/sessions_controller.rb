class SessionsController < ApplicationController
	def create
		auth_hash = request.env["omniauth.auth"].to_hash
		@user = User.find_or_create_by_uid(auth_hash["uid"])
		@user.update_attributes(:icon => auth_hash["info"]["image"], :email => auth_hash["info"]["email"], :token => auth_hash["credentials"]["token"])
		session[:user_id] = @user.id
		redirect_to admin_path
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end
