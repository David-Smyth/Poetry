require 'spec_helper'

describe User do
  # NB: email address must be mixed case here
  before { @user = User.new name: "Demo Dude", 
  	                        email: "Demo@DuDe.uk",
                            password: "some-password",
                            password_confirmation: "some-password"  }
  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :lc_email }
  # Using ActiveModel::has_secure_password
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }
  # Using SessionHelper remember_token, stored in the DB
  # the the session is persistent -- lasts until user signs out
  it { should respond_to :remember_token }


  it { should be_valid }

  describe "when name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long (more than 50 characters)" do
  	before { @user.name = 'Z'*51 }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      # http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/
      # We will really validate using an email round-trip
      @user.email = "there_is-no-at_sign"
      expect(@user).not_to be_valid
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      # Duplicate the user, which will of course have
      # the same email address. Save that to the database.
      # Then, when we validate @user, the existing
      # record will cause @user to be invalid,
      # even if the case is different
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user = User.new name: "Demo Dude", 
  	                          email: "Demo@DuDe.uk",
                              password: " ",
                              password_confirmation: " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do

    before { @user.save }
    let(:found_user) { User.find_by email: @user.email }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }  
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "password must be at least six characters" do
  	before { @user.password = @user.password_confirmation = "p" * 5 }
  	it { should_not be_valid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

end
