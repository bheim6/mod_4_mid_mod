require 'rails_helper'

RSpec.feature "Users can sign up and login" do
  scenario "unauthenticated users are redirected to login page" do
    # As an unauthenticated user, when I visit the root of the application, /,
    visit '/'
    # I should be redirected to a page which prompts me to "Log In or Sign Up".
    expect(current_path).to eq('/login')

    # As an unauthenticated user, if I click "Sign Up", I should be taken to a user form where I can enter an email address, a password, and a password confirmation.
    #
    # I cannot sign up with an email address that has already been used.
    # Password and confirmation must match.
    # If criteria is not met the user should be given a message to reflect the reason they could not sign up.
    # Upon submitting this information, I should be logged in via a session cookie and redirected to the "Links Index" page.

  end
end
