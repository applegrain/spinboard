require "rails_helper"

RSpec.describe "User submits a link" do
  describe "a logged in user" do

    let!(:user) { User.create(username: "Steve", email: "steve@turing.io", password: "password") }

    it "can submit a valid link" do
      login_as(user)

      expect(current_path).to eq links_path

      expect(page).to have_content "Submit a link"

      fill_in "Title", with: "Read this asap"
      fill_in "URL", with: "http://guides.rubyonrails.org/getting_started.html"
      click_button "Add Link"

      expect(current_path).to eq links_path
      expect(page).to have_content "Read this asap"
      expect(page).to have_content "Read: false"
    end

    xit "can't submit links without a title" do
    end

    xit "can't submit invalid links" do
    end
  end
end
