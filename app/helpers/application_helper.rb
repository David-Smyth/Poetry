module ApplicationHelper

	# Provide a page title with optional descriminator
	def page_title(descriminator)
		if descriminator.nil? || descriminator.empty?
			"Poetry | WebApp for Observable Science"
		else
			"Poetry | #{descriminator} WebApp for Observable Science"
		end
	end

end
