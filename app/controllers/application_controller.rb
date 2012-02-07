class ApplicationController < ActionController::Base
  protect_from_forgery

	helper_method :current_user
	helper_method :logged_in?

	before_filter :show_maintenance_page
	
	protected
	def current_user
		if session[:user_id]
			@user = User.find(session[:user_id])
		else
			@user = nil
		end
	end

	def show_maintenance_page
		render :template => "layouts/maintenance", :layout => false
		return false
	end

	def logged_in?
		!!current_user
	end

	def login_required
		unless logged_in?
			redirect_to "/auth/google_oauth2"
		end
	end
end
