require 'rails_helper'

RSpec.feature "Logged in users can submit links" do
  scenario "from the index page" do
    user1 = create(:user)
    visit '/'
    click_on "Log In"
    expect(current_path).to eq('/login')
    fill_in "Email address", with: "example@example.com"
    fill_in "Password", with: user1.password
    fill_in "Password confirmation", with: user1.password
    click_on "Submit"
    # As an authenticated user viewing the main page (links#index), I should see a simple form to submit a link.

    expect(current_path).to eq('/')

    # The Link model should include:
    # A valid URL location for the link
    fill_in "Url", with: "www.google.com"
    # A title for the link
    fill_in "Title", with: "The Google"
    click_on "Submit"

    expect(Link.count).to eq(1)
    # Additionally, all links have a read status that is either true or false. This status will default to false.
    # Submitting an invalid link should result in an error message being displayed that indicated why the user was not able to add the link.
  end
end
