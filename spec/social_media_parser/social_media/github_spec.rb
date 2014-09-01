require 'spec_helper'

describe SocialMediaParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context "correct object" do
    let(:profile_attributes) { {url: "https://github.com/mnddev"} }

    it "returns a Github object" do
      expect(parser).to be_a SocialMediaParser::SocialMedia::Github
    end
  end

  context "with github url and provider" do
    let(:profile_attributes){ {url: "https://github.com/mnddev", provider: "github"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://github.com/mnddev"
      expect(parser.provider).to eq "github"
      expect(parser.username).to eq "mnddev"
    end
  end

  context "with github as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "mnddev", provider: "github"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.github.com/mnddev"
      expect(parser.provider).to eq "github"
      expect(parser.username).to eq "mnddev"
    end
  end

  context "with github as provider and url as url_or_username" do
    let(:profile_attributes){ {url_or_username: "https://github.com/mnddev", provider: "github"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://github.com/mnddev"
      expect(parser.provider).to eq "github"
      expect(parser.username).to eq "mnddev"
    end
  end
end
