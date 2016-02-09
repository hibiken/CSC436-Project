require 'rails_helper'

RSpec.describe Post do
  describe "validations" do
    let(:post) { build(:post) }

    it "is valid" do
      expect(post).to be_valid
    end

    it "is invalid without title" do
      post.title = "   "
      expect(post).to be_invalid
    end

    it "is invalid without content" do
      post.content = "    "
      expect(post).to be_invalid
    end

    it "is valid without user_id" do
      post.user_id = nil
      expect(post).to be_invalid
    end
  end
end
