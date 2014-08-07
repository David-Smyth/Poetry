require 'spec_helper'

describe "Static Pages" do

  describe "Home page" do

    # Capybara provides visit, which sets the page variable
    before { visit root_path }
    subject { page }

  	it { should have_title(page_title('Home of')) }
    it { should have_content('For Scientific Exploration') }

  end

  describe "About page" do

    before { visit about_path }
    subject { page }

  	it { should have_title(page_title('About')) }
  	it { should have_content('MIT License') }

  end

  describe "Help page" do
 
    before { visit help_path }
    subject { page }

    it { should have_title(page_title('Help for')) }
  	it { should have_content('send email to me') }

  end

  describe "Contact page" do
 
    before { visit contact_path }
    subject { page }

    it { should have_title(page_title('Contact Author of')) }
    it { should have_content('David E. Smyth') }

  end

  it "should have the right links on the layout" do
    visit root_path
    expect(page).to have_title(page_title('Home of'))
    click_link "About"
    expect(page).to have_title(page_title('About'))
    click_link "Help"
    expect(page).to have_title(page_title('Help for'))
    click_link "Contact"
    expect(page).to have_title(page_title('Contact Author of'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(user_title('Sign up'))
    click_link "Poetry"
    expect(page).to have_title(page_title('Home of'))
  end
end
