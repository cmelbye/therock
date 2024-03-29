# Helpers used in the assignment manager of the admin panel.
module AssignmentsHelper
  # Returns a status label for the provided Assignment object.
  #
  # The status is something like "Unassigned", "Incomplete", etc.
  # For example,
  #
  #  assignment = Assignment.find(1)
  #  status_label(assignment)
  #  # => <span class="label label-important">Incomplete</span>
	def status_label(assignment)
		if !assignment.assignee_id
			"<span class='label'>Unassigned</span>".html_safe
		elsif assignment.status == Assignment::STATUSES[:complete]
			"<span class='label label-success'>Complete</span>".html_safe
		else
			"<span class='label label-important'>Incomplete</span>".html_safe
		end
	end
end
