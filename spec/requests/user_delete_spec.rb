require 'spec_helper'

describe "Delete User" do 

  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "delete links" do

      describe "as non-admin user" do

        it { should_not have_link('delete') }
      end

      describe "as evil non-admin sending delete without browser" do

        let(:target)    { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin, no_capybara: true }

        describe "submit DELETE request ro Users#destroy action" do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      describe "as admin user" do

        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }

        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end

        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
end