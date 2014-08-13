module UsersHelper

	# Provide a page title with optional descriminator
	def user_title(descriminator)
		if descriminator.nil? || descriminator.empty?
			"Poetry | User Page"
		else
			"Poetry | #{descriminator}"
		end
	end

  # Return Gravatar url for the user, using notes on 
  # http://en.gravatar.com/site/implement/images/
  # Note we use the MD5 hash of the lower case email,
  # the size can be specified or it defaults to 50,
  # and use the 'mystery man' as a default, if there is
  # no Gravatar related to the email address.
  def gravatar_for(user, options={ size: 50 })
    gravatar_com  = "https://secure.gravatar.com/avatar"
    gravatar_id   = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_opts = "s=#{options[:size]}?d=mm"
    gravatar_url = "#{gravatar_com}/#{gravatar_id}?#{gravatar_opts}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

end
