require 'spec_helper'

describe SocialMediaParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context "correct class" do
    let(:profile_attributes) { {url: "https://plus.google.com/+TeamCoco"} }

    it "returns a Google object" do
      expect(parser).to be_a SocialMediaParser::Provider::Google
    end
  end

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

  context "url variations" do
    it "parses username from url with trailing slash" do
      parser = described_class.parse "plus.google.com/+TeamCoco/"
      expect(parser.username).to eq "TeamCoco"
    end

    it "parses username from url without http" do
      parser = described_class.parse "plus.google.com/+TeamCoco"
      expect(parser.username).to eq "TeamCoco"
    end

    it "parses username from post url and multi user login" do
      parser = described_class.parse "https://plus.google.com/u/1/+TeamCoco/posts/B1n3wkASqno"
      expect(parser.username).to eq "TeamCoco"
    end

    it "parses username from photo url" do
      parser = described_class.parse "https://plus.google.com/+TeamCoco/photos/photo/6049107252378797394?pid=6049107252378797394&oid=105163107119743094340"
      expect(parser.username).to eq "TeamCoco"
    end

    it "parses username from multi user login and with special characters" do
      parser = described_class.parse "https://plus.google.com/u/0/+KristoferBj%C3%B6rkman/posts"
      expect(parser.username).to eq "KristoferBj%C3%B6rkman"
    end
  end
end
