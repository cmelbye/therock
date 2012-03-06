# Represents an assignment in the database.
class Assignment < ActiveRecord::Base
  # These status constants are used to determine if an assignment
  # is complete, incomplete, etc.
  # It's used in AssignmentsHelper#status_label
  # to show a human-readable representation of the status of the assignment.
	STATUSES = {:complete => 100, :incomplete => 101}

	validates_presence_of :summary
	validates_presence_of :due
	validates_presence_of :section_id
	validates_presence_of :assignee_id

	belongs_to :assignee, :class_name => "User"
	belongs_to :assignor, :class_name => "User"
  
  # Virtual attribute that facilitates setting the assignee
  # name in the assignee autocompleter.
  attr_writer :assignee_name
end
