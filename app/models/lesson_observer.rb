class LessonObserver < ActiveRecord::Observer
	observe :lesson
	def after_create(l)
		l.contracts.each { |c|
			c.update_attributes(:done_hours => c.done_hours + l.hours)
		}
	end

	def after_update(l)
		if l.hours_changed?
			l.contracts.each { |c|
				c.update_attributes(:done_hours => c.done_hours - l.hours_was + l.hours )
			}
		end
	end

	def after_destroy(l)
		l.contracts.each { |c|
			c.update_attributes(:done_hours => c.done_hours + l.hours )
		}
	end
end