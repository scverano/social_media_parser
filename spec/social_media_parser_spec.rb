require 'spec_helper'

describe SocialMediaParser do
  describe ".parse" do
    let(:profile_attributes){ {url: "https://twitter.com/john_snow", provider: 'twitter'} }

    it "returns a Base class instance" do
      expect(described_class.parse(profile_attributes)).to be_a SocialMediaParser::Base
    end
  end
end
