require 'rails_helper'

RSpec.describe User do

  describe "validations" do
    let(:user) { build(:user) }

    it "is valid" do
      expect(user).to be_valid
    end

    it "is invalid without first name" do
      user.first_name = "   "
      expect(user).to be_invalid
    end

    it "is invalid without last name" do
      user.last_name = "   "
      expect(user).to be_invalid
    end

    it "is invalid without email" do
      user.email = "  "
      expect(user).to be_invalid
    end

    it "requires email to be well-formatted" do
      invalid_addresses = %w(user@example,com user_at_foo.org user@example. foo@bar_baz.com
      foo@bar+baz.com)

      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to be_invalid
      end
    end

    it "requires email to be unique" do
      user1 = create(:user, email: "example@email.com")
      user2 = build(:user,  email: "example@email.com")

      expect(user2).to be_invalid
    end
  end

  describe "callback hooks" do
    it "downcases email before saving to the database" do
      user = build(:user, email: "EXAMPLE@gmail.com")
      user.save
      expect(user.reload.email).to eq("example@gmail.com")
    end
  end

end
