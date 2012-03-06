# Base class for all controllers in the application.
class ApplicationController < ActionController::Base
  protect_from_forgery

	helper_method :current_user
	helper_method :logged_in?

	protected
  # Returns the User object of the currently logged in user, otherwise
  # returns <tt>nil</tt> if no one is logged in.
	def current_user
		if session[:user_id]
			@user = User.find(session[:user_id])
		else
			@user = nil
		end
	end
  
  # Renders a simple maintenance page.
  #
  # Intended to be used as a <tt>before_filter</tt>.
	def show_maintenance_page
		render :template => "layouts/maintenance", :layout => false
		return false
	end
  
  # Returns <tt>true</tt> if the user is logged in, otherwise returns <tt>false</tt>.
	def logged_in?
		!!current_user
	end
  
  # Unless the user is logged in, the user is redirected to the
  # authentication page.
  #
  # Intended to be used as a <tt>before_filter</tt>.
	def login_required
		unless logged_in?
			redirect_to "/auth/google_oauth2"
		end
	end
end
