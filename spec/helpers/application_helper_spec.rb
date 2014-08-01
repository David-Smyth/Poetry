require 'spec_helper'

describe ApplicationHelper do

  describe "page_title" do
    it "should include the page title" do
      expect(page_title("foo")).to match(/foo/)
    end

    it "should include the app name" do
      expect(page_title("foo")).to match(/^Poetry |/)
    end

    it "should include the base title" do
      expect(page_title("foo")).to match(/WebApp for Observable Science$/)
    end

    it "should not have empty space if empty discriminator" do
      expect(page_title("")).to match(/^Poetry | WebApp for Observable Science/)
    end

    it "should work for Home page" do
      expect(page_title('Home of')).to match(/^Poetry | Home of WebApp for Observable Science/)
    end

    it "should work for About page" do
      expect(page_title('About')).to match(/^Poetry | About WebApp for Observable Science/)
    end

    it "should work for Contact Author of page" do
      expect(page_title('Contact Author of')).to match(/^Poetry | Contact Author of WebApp for Observable Science/)
    end

    it "should work for Help for page" do
      expect(page_title('Help for')).to match(/^Poetry | Help for WebApp for Observable Science/)
    end

  end
end