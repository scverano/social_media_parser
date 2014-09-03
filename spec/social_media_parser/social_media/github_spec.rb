require 'spec_helper'

describe SocialMediaParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context "correct object" do
    let(:profile_attributes) { {url: "https://github.com/mynewsdesk"} }

    it "returns a Github object" do
      expect(parser).to be_a SocialMediaParser::SocialMedia::Github
    end
  end

  context "with github url and provider" do
    let(:profile_attributes){ {url: "https://github.com/mynewsdesk", provider: "github"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://github.com/mynewsdesk"
      expect(parser.provider).to eq "github"
      expect(parser.username).to eq "mynewsdesk"
    end
  end

  context "with github as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "mynewsdesk", provider: "github"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.github.com/mynewsdesk"
      expect(parser.provider).to eq "github"
      expect(parser.username).to eq "mynewsdesk"
    end
  end

  context "with github as provider and url as url_or_username" do
    let(:profile_attributes){ {url_or_username: "https://github.com/mynewsdesk", provider: "github"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://github.com/mynewsdesk"
      expect(parser.provider).to eq "github"
      expect(parser.username).to eq "mynewsdesk"
    end
  end

  context "url variations" do
    it "parses username from url with trailing slash" do
      parser = described_class.parse "https://github.com/teamcoco/"
      expect(parser.username).to eq "teamcoco"
    end

    it "parses username from url without www" do
      parser = described_class.parse "https://github.com/mynewsdesk"
      expect(parser.username).to eq "mynewsdesk"
    end

    it "parses username from url without http" do
      parser = described_class.parse "www.github.com/mynewsdesk"
      expect(parser.username).to eq "mynewsdesk"
    end

    it "parses username from url without http and www" do
      parser = described_class.parse "github.com/mynewsdesk"
      expect(parser.username).to eq "mynewsdesk"
    end

    it "parses username from repo url" do
      parser = described_class.parse "https://github.com/mynewsdesk/social_media_parser"
      expect(parser.username).to eq "mynewsdesk"
    end

    it "parses username from repo open issues url" do
      parser = described_class.parse "https://github.com/mynewsdesk/social_media_parser/issues?q=is%3Aopen+is%3Aissue"
      expect(parser.username).to eq "mynewsdesk"
    end
  end
end
