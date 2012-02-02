class ApplicationController < ActionController::Base
  protect_from_forgery

	helper_method :current_user
	helper_method :logged_in?

	protected
	def current_user
		if session[:user_id]
			@user = User.find(session[:user_id])
		else
			@user = nil
		end
	end

	def logged_in?
		!!current_user
	end
end
