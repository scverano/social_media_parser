require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

  context "correct class" do
    let(:profile_attributes) { {url: "https://pinterest.com/fallontonight"} }

    it "returns a Pinterest object" do
      expect(parser).to be_a SocialMediaParser::Provider::Pinterest
    end
  end

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

  context "url variations" do
    it "parses username from url without trailing slash" do
      parser = described_class.parse "http://www.pinterest.com/marthastewart"
      expect(parser.username).to eq "marthastewart"
    end

    it "parses username from url without www" do
      parser = described_class.parse "http://pinterest.com/marthastewart/"
      expect(parser.username).to eq "marthastewart"
    end

    it "parses username from pinterest pinboard url" do
      parser = described_class.parse "http://www.pinterest.com/marthastewart/around-my-farm/"
      expect(parser.username).to eq "marthastewart"
    end

    it "parses username from pinterest followers url" do
      parser = described_class.parse "http://www.pinterest.com/marthastewart/followers/"
      expect(parser.username).to eq "marthastewart"
    end
  end
end
