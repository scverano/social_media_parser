require 'spec_helper'

describe SocialMediaParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context "with google plus url as url_or_username and provider" do
    let(:profile_attributes){ {url_or_username: "https://plus.google.com/+TeamCoco/posts", provider: "google"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://plus.google.com/+TeamCoco/posts"
      expect(parser.provider).to eq "google"
      expect(parser.username).to eq "TeamCoco"
    end
  end

  context "with google provider and custom username" do
    let(:profile_attributes){ {username: "TeamCoco", provider: "google"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://plus.google.com/+TeamCoco"
      expect(parser.provider).to eq "google"
      expect(parser.username).to eq "TeamCoco"
    end
  end

  context "with google provider and numeric id as username" do
    let(:profile_attributes){ {username: "105063820137409755625", provider: "google"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://plus.google.com/105063820137409755625"
      expect(parser.provider).to eq "google"
      expect(parser.username).to eq "105063820137409755625"
    end
  end
end
