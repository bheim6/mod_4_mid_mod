require 'rails_helper'

RSpec.feature "Users can sign up and login" do
  scenario "unauthenticated users are redirected to login page and can sign up" do
    # As an unauthenticated user, when I visit the root of the application, /,
    visit '/'
    # binding.pry
    # I should be redirected to a page which prompts me to "Log In or Sign Up".
    expect(current_path).to eq('/login_router')
    # As an unauthenticated user, if I click "Sign Up", I should be taken to a user form where I can enter an email address, a password, and a password confirmation.
    click_on "Sign Up"
    expect(current_path).to eq('/signup')
    fill_in "Email address", with: "example@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Submit"
    # Upon submitting this information, I should be logged in via a session cookie and redirected to the "Links Index" page.
    expect(current_path).to eq('/')
  end

  # I cannot sign up with an email address that has already been used.
  # Password and confirmation must match.
  # If criteria is not met the user should be given a message to reflect the reason they could not sign up.

  scenario "Users can log in and sign out from the root page" do
    user1 = create(:user)
    visit '/'
    click_on "Log In"
    expect(current_path).to eq('/login')
    fill_in "Email address", with: "example@example.com"
    fill_in "Password", with: user1.password
    fill_in "Password confirmation", with: user1.password
    click_on "Submit"

    expect(current_path).to eq('/')
    # As an authenticated user viewing the index page, I should see a link to "Sign Out" and not see a link to "Sign In".
    expect(page).to have_link("Sign Out")
    expect(page).to_not have_link("Sign In")

    click_link "Sign Out"
    # This should redirect me back to the root of the application where I should see a link to "Log In".
    expect(current_path).to eq('/login_router')
    expect(page).to have_link('Log In')
  end
end
