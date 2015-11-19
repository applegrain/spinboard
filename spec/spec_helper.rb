require "simplecov"
SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def login_as(user, action = "Log In", submit = "Log In")
    visit root_path

    click_link action
    fill_in "Username",              with: user.username
    fill_in "Password",              with: user.password
    fill_in "Password confirmation", with: user.password
    click_button submit
  end
end
