require 'spec_helper'

describe SocialMediaParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context "correct object" do
    let(:profile_attributes) { {url: "https://www.facebook.com/teamcoco"} }

    it "returns a Facebook object" do
      expect(parser).to be_a SocialMediaParser::SocialMedia::Facebook
    end
  end

  context "with facebook url and provider" do
    let(:profile_attributes){ {url: "https://facebook.com/awesome_random_dude", provider: "facebook"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://facebook.com/awesome_random_dude"
      expect(parser.provider).to eq "facebook"
      expect(parser.username).to eq "awesome_random_dude"
    end
  end

  context "with facebook profile_id url and provider" do
    let(:profile_attributes){ {url: "https://www.facebook.com/profile.php?id=644727125&fref=nf", provider: "facebook"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.facebook.com/profile.php?id=644727125&fref=nf"
      expect(parser.provider).to eq "facebook"
      expect(parser.username).to eq "644727125"
    end
  end

  context "with facebook username as url_or_username and provider" do
    let(:profile_attributes){ {url_or_username: "john.snow", provider: "facebook"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.facebook.com/john.snow"
      expect(parser.provider).to eq "facebook"
      expect(parser.username).to eq "john.snow"
    end
  end

  context "with facebook http url as url_or_username and case insensitive provider" do
    let(:profile_attributes){ {url_or_username: "http://www.facebook.com/john.snow", provider: "Facebook"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "http://www.facebook.com/john.snow"
      expect(parser.provider).to eq "facebook"
      expect(parser.username).to eq "john.snow"
    end
  end
end
