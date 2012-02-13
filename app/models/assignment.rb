class Assignment < ActiveRecord::Base
	STATUSES = {:complete => 100, :incomplete => 101}

	validates_presence_of :summary
	validates_presence_of :due
	validates_presence_of :section_id
	validates_presence_of :assignee_id

	belongs_to :assignee, :class_name => "User"
	belongs_to :assignor, :class_name => "User"

	def assignee_name
		@assignee_name
	end

	def assignee_name=(val)
		@assignee_name = val
	end
end
