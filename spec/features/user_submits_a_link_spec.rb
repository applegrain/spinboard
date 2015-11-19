require "rails_helper"

RSpec.describe "User submits a link" do
  describe "a logged in user" do

    let!(:user) { User.create(username: "Steve", email: "steve@turing.io", password: "password") }

    xit "can submit a valid link" do
      login_as(user)

      expect(current_path).to eq links_path

      expect(page).to have_content "Submit a link"

      fill_in "Title", with: "Read this asap"
      fill_in "URL", with: "http://guides.rubyonrails.org/getting_started.html"
      click_button "Add Link"

      expect(current_path).to eq links_path
      expect(page).to have_content "Read this asap"
      expect(page).to have_content "Status: unread"
    end

    it "can't submit links without a title" do
      login_as(user)

      expect(current_path).to eq links_path

      fill_in "URL", with: "http://guides.rubyonrails.org/getting_started.html"
      click_button "Add Link"

      expect(current_path).to eq links_path
      expect(page).to have_content "Title can't be blank"
    end

    it "can't submit invalid links" do
      login_as(user)

      expect(current_path).to eq links_path

      fill_in "Title", with: "whwwwww"
      click_button "Add Link"

      expect(current_path).to eq links_path
      expect(page).to have_content "Url can't be blank"
    end

    it "can't submit links without a title and url" do
      login_as(user)

      expect(current_path).to eq links_path

      click_button "Add Link"

      expect(current_path).to eq links_path
      expect(page).to have_content "Title can't be blank, Url can't be blank"
    end
  end
end
