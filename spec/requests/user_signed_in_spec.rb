require 'spec_helper'

describe "User signin:" do

  describe "when user has signed in" do
    let(:user)     { FactoryGirl.create(:user) }
    let(:new_user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }

    describe "users#new redirects to root" do
      before { get new_user_path }
      specify { response.should redirect_to(root_path) }
    end
  end
end

    
