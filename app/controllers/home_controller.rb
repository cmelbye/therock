class HomeController < ApplicationController
  def index
  	@posts = Post.order("id DESC").all
  end

end
