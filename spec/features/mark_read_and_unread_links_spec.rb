require "rails_helper"

RSpec.describe "Marking links read and unread" do
  describe "an unread link" do
    let!(:user) { User.create(username: "Steve", email: "steve@turing.io", password: "password") }

    xit "can get marked as read" do
      login_as(user, "Sign Up", "Create Account")

      fill_in "Title", with: "Read this asap"
      fill_in "URL", with: "http://guides.rubyonrails.org/getting_started.html"
      click_button "Add Link"

      expect(page).to have_button "Mark as read"
      click_button "Mark as read"

      expect(page).to have_content "Mark as unread"
    end
  end

  describe "a read link" do
    let!(:user) { User.create(username: "Steve", email: "steve@turing.io", password: "password") }

    xit "can get marked as unread" do
      login_as(user, "Sign Up", "Create Account")

      fill_in "Title", with: "Read this asap"
      fill_in "URL", with: "http://guides.rubyonrails.org/getting_started.html"
      click_button "Add Link"

      expect(page).to have_button "Mark as read"
      click_button "Mark as read"

      expect(page).to have_content "Mark as unread"
      click_button "Mark as unread"

      expect(page).to have_content "Mark as read"
    end
  end
end
