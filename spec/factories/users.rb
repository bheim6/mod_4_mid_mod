FactoryGirl.define do
  factory :user do
    email_address "example@example.com"
    password_digest "password"
    password_confirmation "password"
  end
end
