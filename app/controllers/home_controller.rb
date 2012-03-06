# Controller for public-facing site.
class HomeController < ApplicationController
  # Finds all posts
  def index
  	@posts = Post.order("id DESC").all
  end

end
