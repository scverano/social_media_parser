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

  context "url variations" do
    it "parses username from url without trailing slash" do
      parser = described_class.parse "https://twitter.com/TEDTalks"
      expect(parser.username).to eq "TEDTalks"
    end

    it "parses username from url with www" do
      parser = described_class.parse "https://www.twitter.com/TEDTalks/"
      expect(parser.username).to eq "TEDTalks"
    end

    it "parses username from url without http" do
      parser = described_class.parse "twitter.com/TEDTalks/"
      expect(parser.username).to eq "TEDTalks"
    end

    it "parses username from tweet url" do
      parser = described_class.parse "https://twitter.com/TEDTalks/status/506827261379874816"
      expect(parser.username).to eq "TEDTalks"
    end

    it "parses username from twitter media url" do
      parser = described_class.parse "https://twitter.com/TEDTalks/media"
      expect(parser.username).to eq "TEDTalks"
    end

    context "old twitter urls" do
      it "parses username from twitter profile page url" do
        parser = described_class.parse "http://twitter.com/#!/johnnycullen"
        expect(parser.username).to eq "johnnycullen"
      end

      it "parses username from tweet url" do
        parser = described_class.parse "https://twitter.com/#!/JohnnyCullen/status/507124787546968064"
        expect(parser.username).to eq "JohnnyCullen"
      end
    end
  end
end
