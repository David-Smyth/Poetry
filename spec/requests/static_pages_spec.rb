require 'spec_helper'

describe "Static Pages" do
  describe "Home page" do
  	it "should have title 'Poetry'" do
      visit '/static_pages/home'
      expect(page).to have_title('Poetry | Home of WebApp for')
    end
    it "should have the content 'For Scientific Exploration'" do
      # Capybara provides visit, which sets the page variable
      visit '/static_pages/home'
      expect(page).to have_content('For Scientific Exploration')
    end
  end
  describe "About page" do
  	it "should have title with 'About'" do
  	  visit '/static_pages/about'
  	  expect(page).to have_title('About')
  	end
  	it "should have content 'MIT License'" do
  	  visit '/static_pages/about'
  	  expect(page).to have_content('MIT License')
  	end
  end
  describe "Help page" do
  	it "should have title with 'Help for'" do
  	  visit '/static_pages/help'
  	  expect(page).to have_title('Help for')
  	end
  	it "should have content with 'mailto:Capt.David.Smyth@gmail.com'" do
  	  visit '/static_pages/help'
  	  expect(page).to have_content('send email to me')
  	end
  end
  describe "Contact page" do
  	it "should have title with Contact" do
      visit '/static_pages/contact'
      expect(page).to have_title('Contact Author of')
    end
    it "should have content with 'mailto:Capt.David.Smyth@gmail.com'" do
      visit '/static_pages/contact'
      expect(page).to have_content('David E. Smyth')
    end
  end
end
