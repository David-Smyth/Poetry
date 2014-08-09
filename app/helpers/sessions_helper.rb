module SessionsHelper

  # Provide a page title with optional descriminator
  def session_title(descriminator)
    if descriminator.nil? || descriminator.empty?
      "Poetry | Session"
    else
      "Poetry | Session #{descriminator}"
    end
  end

  # Signin results in a cookie on the user's browser
  # containing the remember_token. The token is then used
  # to look up the user record in the database each time
  # the user visits a page. Note the cookie is one value,
  # just a random number. The database holds the encrypted
  # digest. So given the DB, still can't forge the token.
  # And while the cookie can be read by any other web page,
  # it can't be used alone to access the database. I think?
  def sign_in(user)
    # A random value
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  # Fill the remember_token digest field in the DB for this
  # user with junk, so nobody can steal the cookie can keep
  # using it, acting like the user.
  def sign_out
    junk_remember_token = User.new_remember_token
    junk_rt_digest = User.digest(junk_remember_token)
    current_user.update_attribute(:remember_token,junk_rt_digest)
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

end
