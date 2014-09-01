require 'spec_helper'

describe SocialMediaParser do
  let(:parser){ described_class.parse profile_attributes }

  context "with just an url" do
    context "with a valid url" do
      let(:profile_attributes){ {url: "http://www.url.com"} }

      it "returns the parsed attributes" do
        expect(parser.url).to eq "http://www.url.com"
        expect(parser.provider).to be_nil
        expect(parser.username).to be_nil
      end
    end
  end

  context "with an unknown provider" do
    let(:result){ described_class.new(profile_attributes).attributes }
    let(:profile_attributes){ {url: "http://unknown.com/john_snow", provider: "unknown", username: "john_snow"} }

    it "returns nil" do
      expect(parser.url).to eq "http://unknown.com/john_snow"
      expect(parser.provider).to eq nil
      expect(parser.username).to eq nil
    end
  end

  context "#url" do
    context "with a valid url" do
      let(:profile_attributes){ {url: "http://www.url.com"} }

      it "returns the url" do
        expect(parser.url).to eq "http://www.url.com"
      end
    end

    context "with an url missing scheme" do
      let(:profile_attributes){ {url: "www.url.com"} }

      it "returns the url prefixed with http" do
        expect(parser.url).to eq "http://www.url.com"
      end
    end

    context "with an url missing scheme without www" do
      let(:profile_attributes){ {url: "url.com"} }

      it "returns the url prefixed with http" do
        expect(parser.url).to eq "http://url.com"
      end
    end

    context "with an url containing path" do
      let(:profile_attributes){ {url: "url.com/epic/lol"} }

      it "returns the url with http" do
        expect(parser.url).to eq "http://url.com/epic/lol"
      end
    end
  end
end
