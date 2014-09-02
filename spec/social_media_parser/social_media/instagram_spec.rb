require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

  context "with instagram url and provider" do
    let(:profile_attributes){ {url: "https://instagram.com/jimmykimmellive", provider: "instagram"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://instagram.com/jimmykimmellive"
      expect(parser.provider).to eq "instagram"
      expect(parser.username).to eq "jimmykimmellive"
    end
  end

  context "with instagram as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "jimmykimmellive", provider: "instagram"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.instagram.com/jimmykimmellive"
      expect(parser.provider).to eq "instagram"
      expect(parser.username).to eq "jimmykimmellive"
    end
  end

  context "with instagram as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "https://instagram.com/jimmykimmellive", provider: "instagram"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://instagram.com/jimmykimmellive"
      expect(parser.provider).to eq "instagram"
      expect(parser.username).to eq "jimmykimmellive"
    end
  end

  context "url variations" do
    it "parses username from url with trailing slash" do
      parser = described_class.parse "http://instagram.com/jimmyfallon/"
      expect(parser.username).to eq "jimmyfallon"
    end

    it "parses username from url with www" do
      parser = described_class.parse "http://www.instagram.com/jimmyfallon"
      expect(parser.username).to eq "jimmyfallon"
    end

    it "parses username from url without http and www" do
      parser = described_class.parse "instagram.com/jimmyfallon"
      expect(parser.username).to eq "jimmyfallon"
    end
  end
end
