require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
	it "Should have the content 'Sample App'" do
      visit '/static_pages/home'
	  expect(page).to have_content('Sample App')
    end
	it "Should have the base app title" do
      visit '/static_pages/home'
	  expect(page).to have_title('Rails Sample App')
    end
	it "Should NOT have the title 'Home'" do
      visit '/static_pages/home'
	  expect(page).not_to have_title('Home')
    end
  end
  
  describe "Help page" do
	it "Should have the content 'Help'" do
      visit '/static_pages/help'
	  expect(page).to have_content('Help')
    end
	it "Should have the title 'Help'" do
      visit '/static_pages/help'
	  expect(page).to have_title('Help')
    end
  end
  
  describe "About page" do
	it "Should have the content 'About'" do
      visit '/static_pages/about'
	  expect(page).to have_content('About')
    end
	it "Should have the title 'About'" do
      visit '/static_pages/about'
	  expect(page).to have_title('About')
    end
  end
  
end
