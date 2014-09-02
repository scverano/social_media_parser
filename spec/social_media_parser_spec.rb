require 'spec_helper'

describe SocialMediaParser do
  describe ".parse" do
    let(:profile_attributes){ {url: "https://twitter.com/StephenAtHome", provider: 'twitter'} }

    it "returns a Twitter instance" do
      expect(described_class.parse(profile_attributes)).to be_a SocialMediaParser::SocialMedia::Twitter
    end

    describe "string key hash" do
      let(:profile_attributes){ {"url" => "https://twitter.com/StephenAtHome", "provider" => 'twitter'} }

      it "still works" do
        expect(described_class.parse(profile_attributes)).to be_a SocialMediaParser::SocialMedia::Twitter
      end
    end

    describe "passing just a url string" do
      let(:profile_attributes){ "https://twitter.com/StephenAtHome" }

      it "still works" do
        expect(described_class.parse(profile_attributes)).to be_a SocialMediaParser::SocialMedia::Twitter
      end
    end
  end
end
