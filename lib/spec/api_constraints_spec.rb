require "spec_helper"
require "api_constraints"

RSpec.describe ApiConstraints do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1) }
  let(:api_constraints_v2) { ApiConstraints.new(version: 2, default: true) }

  describe "#matches?" do

    it "returns true when the version mathes the 'Accept' header field" do
      request = double(host: 'api.socialmedia.dev',
                       headers: { 'Accept' => 'application/vnd.socialmedia.v1+json' })
      expect(api_constraints_v1.matches?(request)).to be_truthy
    end

    it "returns true if it is set to default" do
      request = double(host: 'api.socialmedia.dev',
                       headers: { 'Accept' => nil })
      expect(api_constraints_v2.matches?(request)).to be_truthy
      expect(api_constraints_v1.matches?(request)).to be_falsy
    end
  end
end
