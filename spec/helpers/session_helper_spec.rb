require 'spec_helper'

describe SessionsHelper do

  describe "session_title" do
    it "should include the descriminator" do
      expect(session_title("foo")).to match(/foo/)
    end

    it "should include the app name" do
      expect(session_title("foo")).to match(/^Poetry |/)
    end

    it "should not have empty space if empty discriminator" do
      expect(user_title("")).to match(/^Poetry | Session/)
    end

    it "should work for arbitrary text" do
      expect(user_title('Sign In')).to match(/^Poetry | Session Sign In/)
    end

  end
end