require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should have_secure_password }
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :email_address }
    it { should validate_uniqueness_of :email_address }
  end
end
