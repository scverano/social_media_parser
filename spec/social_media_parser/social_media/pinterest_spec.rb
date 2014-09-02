require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

  context "with pinterest url and provider" do
    let(:profile_attributes){ {url: "https://pinterest.com/fallontonight", provider: "pinterest"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://pinterest.com/fallontonight"
      expect(parser.provider).to eq "pinterest"
      expect(parser.username).to eq "fallontonight"
    end
  end

  context "with pinterest as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "fallontonight", provider: "pinterest"} }

    it "returns the parsed attributes" do
      expect(parser.url).to eq "https://www.pinterest.com/fallontonight"
      expect(parser.provider).to eq "pinterest"
      expect(parser.username).to eq "fallontonight"
    end
  end

  context "with pinterest as provider and username as url_or_username" do
    let(:profile_attributes){ {url_or_username: "https://www.pinterest.com/fallontonight", provider: "pinterest"} }

    it "returns nil" do
      expect(parser.url).to eq "https://www.pinterest.com/fallontonight"
      expect(parser.provider).to eq "pinterest"
      expect(parser.username).to eq "fallontonight"
    end
  end
end
