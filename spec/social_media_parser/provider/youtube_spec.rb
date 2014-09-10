require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

  context "correct class" do
    let(:profile_attributes) { {url: "https://www.youtube.com/user/TeamCoco"} }

    it "returns a Youtube object" do
      expect(parser).to be_a SocialMediaParser::Provider::Youtube
    end
  end

  context "with url and provider" do
    let(:profile_attributes){ {url: "https://www.youtube.com/user/teamcoco", provider: "youtube"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.youtube.com/user/teamcoco"
      expect(parser.provider).to eq "youtube"
      expect(parser.username).to eq "teamcoco"
    end
  end

  context "with username and provider" do
    let(:profile_attributes){ {username: "TeamCoco", provider: "youtube"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.youtube.com/user/TeamCoco"
      expect(parser.provider).to eq "youtube"
      expect(parser.username).to eq "TeamCoco"
    end
  end

  context "with username as url_or_username and provider" do
    let(:profile_attributes){ {url_or_username: "TeamCoco", provider: "youtube"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.youtube.com/user/TeamCoco"
      expect(parser.provider).to eq "youtube"
      expect(parser.username).to eq "TeamCoco"
    end
  end

  context "url variations" do
    it "parses username from url with trailing slash" do
      parser = described_class.parse "https://www.youtube.com/user/collegehumor/"
      expect(parser.username).to eq "collegehumor"
    end

    it "parses username from url without user" do
      parser = described_class.parse "https://www.youtube.com/user/collegehumor"
      expect(parser.username).to eq "collegehumor"
    end

    it "parses username from a users channels url" do
      parser = described_class.parse "https://www.youtube.com/user/collegehumor/channels"
      expect(parser.username).to eq "collegehumor"
    end

    it "doesn't parse channel urls - returns them as usual links" do
      parser = described_class.parse "https://www.youtube.com/channel/UCn8zNIfYAQNdrFRrr8oibKw"
      expect(parser.username).to eq nil
      expect(parser).to be_a SocialMediaParser::Link
    end

    it "doesn't parse playlist urls - returns them as usual links" do
      parser = described_class.parse "https://www.youtube.com/playlist?list=PLA3D67612B92CD08B"
      expect(parser.username).to eq nil
      expect(parser).to be_a SocialMediaParser::Link
    end
  end
end
