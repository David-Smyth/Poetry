require 'spec_helper'

describe "User Profile" do

  subject { page }

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_title(user.name) }
      it { should have_title("Edit") }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      it { should have_content("Update your profile") }
      it { should have_content("Name") }
      it { should have_content("Email") }
      it { should have_content("Password") }
      it { should have_content("Confirm password") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end
end

