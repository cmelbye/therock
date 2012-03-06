module Admin #:nodoc:
end

# Controller for root admin pages.
class AdminController < ApplicationController
  layout "admin"
  before_filter :login_required

  # Determines the current time and generates an appropriate greeting
  # for the user depending on the time of day.
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
