require 'spec_helper'

describe UsersHelper do

  describe "user_title" do
    it "should include the page title" do
      expect(user_title("foo")).to match(/foo/)
    end

    it "should include the app name" do
      expect(user_title("foo")).to match(/^Poetry |/)
    end

    it "should not have empty space if empty discriminator" do
      expect(user_title("")).to match(/^Poetry | User Page/)
    end

    it "should work for arbitrary text" do
      expect(user_title('Profile of')).to match(/^Poetry | Profile of/)
    end

  end
end