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

  context "url variations" do
    it "parses username from url with trailing slash" do
      parser = described_class.parse "https://www.facebook.com/teamcoco/"
      expect(parser.username).to eq "teamcoco"
    end

    it "parses username from url without www" do
      parser = described_class.parse "https://facebook.com/teamcoco"
      expect(parser.username).to eq "teamcoco"
    end

    it "parses username from url without http" do
      parser = described_class.parse "www.facebook.com/teamcoco"
      expect(parser.username).to eq "teamcoco"
    end

    it "parses username from url without http and www" do
      parser = described_class.parse "facebook.com/teamcoco"
      expect(parser.username).to eq "teamcoco"
    end

    it "parses username from photo stream page url" do
      parser = described_class.parse "https://www.facebook.com/teamcoco/photos_stream"
      expect(parser.username).to eq "teamcoco"
    end

    it "parses username from photo url" do
      parser = described_class.parse "https://www.facebook.com/teamcoco/photos/pb.108905269168364.-2207520000.1409669893./757027907689427/?type=3&theater"
      expect(parser.username).to eq "teamcoco"
    end

    it "parses username from facebook pages with username url" do
      parser = described_class.parse "https://www.facebook.com/natten4ever"
      expect(parser.username).to eq "natten4ever"
    end

    # Usernames derived from Facebook pages urls without username uses id as unique handler
    # Since page name isn't usable in the Graph API, we chose to return the unique id instead
    context "old facebook pages urls" do
      it "parses Facebook ID as username" do
        parser = described_class.parse "https://www.facebook.com/pages/Stiftelsen-Expo/208751565805849"
        expect(parser.username).to eq "208751565805849"
      end

      it "parses Facebook ID as username from the about page" do
        parser = described_class.parse "https://www.facebook.com/pages/Stiftelsen-Expo/208751565805849?sk=info"
        expect(parser.username).to eq "208751565805849"
      end
    end
  end
end
