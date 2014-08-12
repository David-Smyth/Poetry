require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  let(:sign_in_button) { "Sign in" }

  describe "signin" do
    before { visit signin_path }

    it { should have_title('Sign in') }
    it { should have_content('Sign in') }

    describe "with invalid entries" do
      before { click_button sign_in_button }

      it { should have_title("Sign in") }
      it { should have_selector("div.alert.alert-error") }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid entries" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button sign_in_button
      end

      it { should have_title(user.name) }
      it { should have_link("Profile",  href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }

      it { should have_link("Sign out", href: signout_path)    }
      it { should_not have_link("Sign in",  href: signin_path)     }
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitted the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

      end
    end
  end

end
