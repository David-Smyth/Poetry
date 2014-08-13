require 'spec_helper'

describe "User index" do

  subject { page }

  describe "page" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob",   email: "Bob@OneBigBed.fn")
      FactoryGirl.create(:user, name: "Ted",   email: "Ted@OneBigBed.fn")
      FactoryGirl.create(:user, name: "Carol", email: "Carol@OneBigBed.fn")
      FactoryGirl.create(:user, name: "Alice", email: "Alice@OneBigBed.fn")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }
    it { should have_selector("div.pagination") }

    it "should list all users" do
      User.all.each do |user|
        expect(page).to have_selector 'li', text: user.name
      end
    end
  	
  end

end
