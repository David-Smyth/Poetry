class User < ActiveRecord::Base

  validates :name,  presence: true, length: { maximum: 50 }

  # http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/
  # We will really validate using an email round-trip
  validates :email, presence: true, format: { with: /@/ }

  # lc_email is then checked for uniqueness via a query to the
  # database. For scalability, we make lc_email an index, so its
  # found quickly. And its case insensitive, so its a simple hash
  # or tree or something efficient for the DB to find (or not).
  validates :lc_email, presence: true, uniqueness: true
  
  # Adds attributes password, password_confirmation, password_digest, -- but only
  # digest goes into the database. Adds authorization method.
  has_secure_password
  validates :password, length: { minimum: 6 }

  # Only email should be on the user input form. When email is set,
  # then this method also sets lc_email to be all lower case.
  # We leave email case alone, so we can always display as entered.
  # Hence, we can always display as David.Smyth@Millennium-Space.com
  # if that is how the user entered it.

  #def email=(new_email)
  #  email = new_email
  #  lc_email = email.downcase if not email.nil?
  #end

  after_create      :set_lc_email, prepend: true
  before_validation :set_lc_email, prepend: true
  before_save       :set_lc_email, prepend: true

  def set_lc_email
    self.lc_email = email.downcase if !email.nil?
  end

end


