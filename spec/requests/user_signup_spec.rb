require 'spec_helper'

describe "User Signup Page" do

  subject { page }
  before { visit signup_path }

  let(:submit) { "Create my account" }

  describe "signup page" do
    it { should have_title(user_title('Sign up')) }
    it { should have_content('Sign up') }
  end

  describe "Invalid (empty) form" do
    it "should not create a user" do
      expect { click_button submit }.not_to change(User, :count)
    end
  end

  describe "Fill in form with valid data" do
    before do
      fill_in "Name", with: "David E. Smyth"
      fill_in "Email", with: "Capt.David.Smyth@gmail.com"
      fill_in "Password", with: "LetsDoLunch"
      fill_in "Confirm Password", with: "LetsDoLunch"
    end

    it "should create a user" do
      expect { click_button submit }.to change(User, :count).by(1)
    end
  end
end