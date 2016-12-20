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
    expect(user1.links.count).to eq(1)
    # Additionally, all links have a read status that is either true or false. This status will default to false.
    # Submitting an invalid link should result in an error message being displayed that indicated why the user was not able to add the link.
  end

  scenario "and edit them" do
    user1 = create(:user)
    visit '/'
    click_on "Log In"
    expect(current_path).to eq('/login')
    fill_in "Email address", with: "example@example.com"
    fill_in "Password", with: user1.password
    fill_in "Password confirmation", with: user1.password
    click_on "Submit"

    expect(current_path).to eq('/')

    fill_in "Url", with: "www.google.com"
    fill_in "Title", with: "The Google"
    click_on "Submit"

    expect(page).to have_content("The Google")
    expect(page).to have_content("www.google.com")
    # As an authenticated user who has added links to my URLockbox, when I view the links index:
    click_on "Edit"
    # Each link has an "Edit" button that either takes me to a page to edit the link or allows me to edit the link in place on the page.
    # I can edit the title and/or the url of the link.
    fill_in "Url", with: "https://www.google.com/"
    fill_in "Title", with: "The Googlez"
    click_on "Submit"

    expect(page).to have_content("The Googlez")
    expect(page).to have_content("https://www.google.com/")
    # I cannot change the url to an invalid url. Show the same error message as above.
  end
end
