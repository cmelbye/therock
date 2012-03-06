# Helpers used across the entire application.
module ApplicationHelper
  # Outputs a navigation item that follows Bootstrap
  # markup conventions. This can generally be used for any
  # Bootstrap-based navigation bar or menu.
  #
  # The current request path is automatically checked to determine
  # whether or not the navigation item should be marked as active.
  #
  # ==== Options
  # * <tt>:icon => name of icon</tt> - This option adds an icon
  #   to the navigation item. The name of the icon should be a valid
  #   Bootstrap icon name. A full list of Bootstrap icons can be found
  #   in the {Bootstrap docs}[http://twitter.github.com/bootstrap/base-css.html#icons].
  #
  # ==== Examples
  # To create a navigation item, simply use
  #
  #  nav_item "Home", root_path
  #  # => <li><a href="/">Home</a></li>
  #
  # If the <tt>url</tt> provided matches the current request path,
  # the proper class will be added to the navigation item so that
  # it's styled so that the item is highlighted. For example,
  # assuming the current path is <tt>/posts</tt>:
  #
  #  nav_item "Posts", posts_path
  #  # => <li class="active"><a href="/posts">Posts</a></li>
  #
  # Finally, the <tt>:icon</tt> option can be used to prepend a
  # Bootstrap icon to the navigation item as follows:
  #
  #  nav_item "New Post", new_post_path, :icon => "icon-plus"
  #  # => <li><a href="/posts/new"><i class="icon-plus"></i> New Post</a></li>
	def nav_item(title, url, options={})
		nav_active = (request.fullpath == url)

		icon_white_class = nav_active ? " icon-white" : ""

		icon = options[:icon] ? "<i class='#{options[:icon]}#{icon_white_class}'></i> " : ""

		li_classes = nav_active ? " class='active'" : ""

		output = "<li#{li_classes}>"

		output += link_to (icon + title).html_safe, url

		output += "</li>"

		output.html_safe
	end
end
