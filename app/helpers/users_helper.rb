module UsersHelper

	# Provide a page title with optional descriminator
	def user_title(descriminator)
		if descriminator.nil? || descriminator.empty?
			"Poetry | User Page"
		else
			"Poetry | #{descriminator}"
		end
	end

end
