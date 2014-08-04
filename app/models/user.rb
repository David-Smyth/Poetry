class User < ActiveRecord::Base

  validates :name,  presence: true, length: { maximum: 50 }

  # http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/
  # We will really validate using an email round-trip
  validates :email, presence: true, 
    format: { with: /@/ }, uniqueness: { case_sensitive: false }
  before_save { self.email = email.downcase }
  
  has_secure_password
end
