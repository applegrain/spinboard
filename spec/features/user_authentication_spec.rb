require 'rails_helper'

RSpec.describe "User authentication" do

  describe "an unregistered user" do
    it "is prompted to log in or sign up when they visit the root path" do
      visit root_path
      expect(page).to have_content "Log In or Sign Up"

      click_link "Sign Up"

      expect(current_path).to eq sign_up_path

      fill_in "Username", with: "Steve"
      fill_in "Email", with: "steve@turing.io"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Create Account"

      expect(current_path).to eq links_path
      expect(page).to have_content "Welcome, Steve"
    end

    it "can log out once logged in" do
      visit root_path
      click_link "Sign Up"

      fill_in "Username", with: "Steve"
      fill_in "Email", with: "steve@turing.io"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Create Account"

      expect(page).to have_content "Log Out"
      click_link "Log Out"

      expect(current_path).to eq root_path
    end
  end

  describe "a registered user" do
    let!(:user) { User.create(username: "Steve", email: "steve@turing.io", password: "password") }

    it "can log in" do
      login_as(user)

      expect(current_path).to eq links_path
      expect(page).to have_content "Welcome, Steve"
      expect(page).to have_content "Log Out"
    end

    it "can log out once logged in" do
      login_as(user)

      click_link "Log Out"
      expect(current_path).to eq root_path
    end
  end
end
