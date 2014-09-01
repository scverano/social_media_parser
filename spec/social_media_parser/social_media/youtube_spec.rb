require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

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
      expect(parser.url).to eq "https://www.youtube.com/TeamCoco"
      expect(parser.provider).to eq "youtube"
      expect(parser.username).to eq "TeamCoco"
    end
  end

  context "with username as url_or_username and provider" do
    let(:profile_attributes){ {url_or_username: "TeamCoco", provider: "youtube"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.youtube.com/TeamCoco"
      expect(parser.provider).to eq "youtube"
      expect(parser.username).to eq "TeamCoco"
    end
  end
end
