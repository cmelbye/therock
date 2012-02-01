class SessionsController < ApplicationController
	def create
		render :text => request.env["omniauth.auth"].to_hash.inspect rescue "No Data"
	end
end
