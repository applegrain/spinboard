require 'rails_helper'

RSpec.describe "User authentication" do

  describe "an unregistered user" do
    it "is prompted to log in or sign up when they visit the root path" do
      visit root_path
      expect page.has_content? "Log In or Sign Up"

      click_link "Sign Up"

      expect(current_path).to eq sign_up_path

      fill_in "Username", with: "Steve"
      fill_in "Email", with: "Steve@turing.io"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Create Account"

      expect(current_path).to eq links_path
      expect page.has_content? "Welcome, Steve"
    end

    it "can log out once logged in" do
      visit root_path
      click_link "Sign Up"

      fill_in "Username", with: "Steve"
      fill_in "Email", with: "Steve@turing.io"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Create Account"

      expect page.has_content? "Sign Out"
      click_link "Sign Out"

      expect(current_path).to eq root_path
    end
  end
end
