require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

  context "with twitter as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "TheDailyShow", provider: "twitter"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.twitter.com/TheDailyShow"
      expect(parser.provider).to eq "twitter"
      expect(parser.username).to eq "TheDailyShow"
    end
  end

  context "with twitter as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "https://www.twitter.com/TheDailyShow", provider: "twitter"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.twitter.com/TheDailyShow"
      expect(parser.provider).to eq "twitter"
      expect(parser.username).to eq "TheDailyShow"
    end
  end

  context "with twitter url and provider" do
    let(:profile_attributes){ {url: "https://twitter.com/TheDailyShow", provider: "twitter"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://twitter.com/TheDailyShow"
      expect(parser.provider).to eq "twitter"
      expect(parser.username).to eq "TheDailyShow"
    end
  end
end
