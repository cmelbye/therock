class AdminController < ApplicationController
  layout "admin"
  before_filter :login_required

  def index
    current_time = Time.now.in_time_zone("Mountain Time (US & Canada)")

    case current_time.hour
    when 0..10
      @greeting = "Good morning, %s." % current_user.first_name
    when 11..17
      @greeting = "Good afternoon, %s." % current_user.first_name
    when 18..23
      @greeting = "Good evening, %s." % current_user.first_name
    end
  end

end
