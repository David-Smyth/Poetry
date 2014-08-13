require 'spec_helper'

describe "User index" do

  subject { page }

  describe "page" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 100.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector("div.pagination") }

      it "should list all users" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector 'li', text: user.name
        end
      end
  	end
  end

end
