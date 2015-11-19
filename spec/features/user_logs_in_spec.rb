require 'rails_helper'

RSpec.describe "User logs in" do

  describe "an unregistered user" do
    it "is prompted to log in when you " do
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
      assert page.has_content? "Welcome, Steve"
    end
  end
end
