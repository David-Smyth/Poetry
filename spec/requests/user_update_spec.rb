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
      it { should have_link('Users',    href: users_path) }
      it { should have_link('Profile',  href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }

      it { should have_link('Sign out',    href: signout_path) }
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

    describe "with valid information" do
      let(:new_name)  {"New Name"}
      let(:new_email) {"New@Nosuch.Example.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out') }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
      specify { expect(user.reload.lc_email).to eq new_email.downcase }
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create :user  }
      let(:wrong_user) { FactoryGirl.create :user, email: "MrWong@Over.there" }
      before { sign_in user, no_capybara: true }

      describe "submitting GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match("Edit") }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "forbidden attributes" do
      # Admin is not an attribute that can be changed
      let(:params) do
        { user: { admin: true,
                  password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
   
      specify { expect(user.reload).not_to be_admin }

    end
  end
end

