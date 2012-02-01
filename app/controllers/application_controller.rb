class ApplicationController < ActionController::Base
  protect_from_forgery

	helper_method :current_user
	helper_method :logged_in?

	protected
	def current_user
		@user ||= User.find(session[:id])
	end

	def logged_in?
		!!current_user
	end
end
