class User < ActiveRecord::Base

  validates :name,  presence: true, length: { maximum: 50 }

  # http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/
  # We will really validate using an email round-trip
  validates :email, presence: true, 
    format: { with: /@/ }, uniqueness: { case_sensitive: false }
  before_save { email.downcase! }

  # Adds attributes password, password_confirmation, password_digest, -- but only
  # digest goes into the database. Adds authorization method.
  has_secure_password
  validates :password, length: { minimum: 6 }

end


