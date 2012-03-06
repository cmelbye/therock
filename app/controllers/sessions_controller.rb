# Controller for User sessions
class SessionsController < ApplicationController
  # This action is redirected to after the user authenticates
  # with Google.
  #
  # This action
  # * creates or finds the User object associated with the authenticated user,
  # * updates their attributes (such as first name, last name, etc, as provided
  #   by Google),
  # * initializes their session,
  # * and redirects them to the admin panel.
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
  
  # Destroys the current session, effectively logging the current user out of the admin panel.
  #
  # Redirects to the public-facing site after the session has been terminated.
	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end
