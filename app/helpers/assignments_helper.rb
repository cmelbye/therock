module AssignmentsHelper
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
