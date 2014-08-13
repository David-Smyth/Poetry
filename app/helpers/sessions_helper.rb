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
  # it can't be used alone to access the database. But Why?
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

  def current_user?(user)
    @current_user == user
  end

  # Support "friendly redirect" so when someone tries to access a
  # protected page, such as edit_user_path(user), and they are not
  # signed in, they get redirected to the signin_path, but then after
  # successfully signing in, they get redirected to the path they
  # were trying to go to.

  def remember_protected_path
    # Don't remember path unless its a GET request. If its a post
    # (adding), patch (editing), or delete, we don't remember the
    # requested path. Why? Because we ensure people are signed in
    # before thy start any of those processes, so if they are not
    # signed in, something went wrong, like a forgery, or a browser
    # crash/bug, or a shortcut saved in a user's browser that just
    # won't work in general.
    session[:protected_path_requested] = request.url if request.get?
  end

  def redirect_back_or(default_path)
    redirect_to( session[:protected_path_requested] || default_path )
    session.delete :protected_path_requested
  end
end
