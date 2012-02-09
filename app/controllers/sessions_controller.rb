class SessionsController < ApplicationController
	def create
		auth_hash = request.env["omniauth.auth"].to_hash
		@user = User.find_or_create_by_uid(auth_hash["uid"])
		attrs = {:icon => auth_hash["info"]["image"], :email => auth_hash["info"]["email"], :token => auth_hash["credentials"]["token"]}
		
		unless @user.first_name
			attrs[:first_name] = auth_hash["info"]["first_name"]
		end
		unless @user.last_name
			attrs[:last_name] = auth_hash["info"]["last_name"]
		end

		@user.update_attributes(attrs)
		session[:user_id] = @user.id
		redirect_to admin_path
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end
