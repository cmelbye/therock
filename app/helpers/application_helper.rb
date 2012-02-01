module ApplicationHelper
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
