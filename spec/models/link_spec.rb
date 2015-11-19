require "rails_helper"

RSpec.describe "The Links" do
  describe "#valid_url?" do
    it "returns true if the url is valid" do
      u = "https://gist.github.com/stevekinney/7423bf8d4a4a8622b386"
      expect(Link.valid_url?(u)).to be true
    end
  end
end
