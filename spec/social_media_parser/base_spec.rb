require 'spec_helper'

describe SocialMediaParser::Base do
  let(:parser){ described_class.new profile_attributes }

  describe "#attributes" do
    let(:result){ parser.attributes }

    context "with just an url" do
      context "with a valid url" do
        let(:profile_attributes){ {url: "http://www.url.com"} }

        it "returns the parsed attributes" do
          expect(result[:url]).to eq "http://www.url.com"
          expect(result[:provider]).to be_nil
          expect(result[:username]).to be_nil
        end
      end

      context "with twitter as provider and username as url_or_username" do
        let(:profile_attributes){ {url_or_username: "hodor", provider: 'twitter'} }

        it "returns the parsed attributes" do
          expect(result[:url]).to eq "https://twitter.com/hodor"
          expect(result[:provider]).to eq "twitter"
          expect(result[:username]).to eq "hodor"
        end
      end

      context "with twitter as provider and username as url" do
        let(:profile_attributes){ {url: "hodor", provider: 'twitter'} }

        it "returns the parsed attributes" do
          expect(result[:url]).to eq nil
          expect(result[:provider]).to eq "twitter"
          expect(result[:username]).to eq nil
        end
      end

      context "with twitter url and provider" do
        let(:profile_attributes){ {url: "https://twitter.com/john_snow", provider: 'twitter'} }

        it "returns the parsed attributes" do
          expect(result[:url]).to eq "https://twitter.com/john_snow"
          expect(result[:provider]).to eq "twitter"
          expect(result[:username]).to eq "john_snow"
        end
      end

      context "with facebook url and provider" do
        let(:profile_attributes){ {url: "https://facebook.com/awesome_random_dude", provider: 'facebook'} }

        it "returns the parsed attributes" do
          expect(result[:url]).to eq "https://facebook.com/awesome_random_dude"
          expect(result[:provider]).to eq "facebook"
          expect(result[:username]).to eq "awesome_random_dude"
        end
      end

      context "with facebook profile_id url and provider" do
        let(:profile_attributes){ {url: "https://www.facebook.com/profile.php?id=644727125&fref=nf", provider: 'facebook'} }

        it "returns the parsed attributes" do
          expect(result[:url]).to eq "https://www.facebook.com/profile.php?id=644727125&fref=nf"
          expect(result[:provider]).to eq "facebook"
          expect(result[:username]).to eq "644727125"
        end
      end

      context "with facebook username as url_or_username and provider" do
        let(:profile_attributes){ {url_or_username: "john.snow", provider: 'facebook'} }

        it "returns the facebook profile url" do
          expect(result[:url]).to eq "https://facebook.com/john.snow"
          expect(result[:provider]).to eq "facebook"
          expect(result[:username]).to eq "john.snow"
        end
      end

      context "with youtube as url_or_username and provider" do
        let(:profile_attributes){ {url_or_username: "TeamCoco", provider: 'youtube'} }

        it "returns the facebook profile url" do
          expect(result[:url]).to eq "https://youtube.com/TeamCoco"
          expect(result[:provider]).to eq "youtube"
          expect(result[:username]).to eq "TeamCoco"
        end
      end

      context "with facebook http url as url_or_username and case insensitive provider" do
        let(:profile_attributes){ {url_or_username: "http://www.facebook.com/john.snow", provider: 'Facebook'} }

        it "returns the facebook profile url" do
          expect(result[:url]).to eq "http://www.facebook.com/john.snow"
          expect(result[:provider]).to eq "facebook"
          expect(result[:username]).to eq "john.snow"
        end
      end

      context "with google plus url as url_or_username" do
        let(:profile_attributes){ {url_or_username: "https://plus.google.com/+TeamCoco/posts", provider: 'google'} }

        it "returns the facebook profile url" do
          expect(result[:url]).to eq "https://plus.google.com/+TeamCoco/posts"
          expect(result[:provider]).to eq "google"
          expect(result[:username]).to eq "TeamCoco"
        end
      end

      context "with an unkown provider" do
        let(:profile_attributes){ {url: "http://unknown.com/john_snow", provider: "unknown", username: "john_snow"} }

        it "returns nil" do
          expect(result[:url]).to eq "http://unknown.com/john_snow"
          expect(result[:provider]).to eq nil
          expect(result[:username]).to eq nil
        end
      end
    end
  end

  describe "#url" do
    context "with an url" do
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

    context "#username" do
      context "facebook" do
        let(:profile_attributes){ {provider: "facebook", url: "https://www.facebook.com/teamcoco"} }

        it "parses username correctly" do
          expect(parser.username).to eq "teamcoco"
        end
      end

      context "youtube" do
        let(:profile_attributes){ {provider: "youtube", url: "https://www.youtube.com/user/teamcoco"} }

        it "parses username correctly" do
          expect(parser.username).to eq "teamcoco"
        end
      end

      context "google plus" do
        let(:profile_attributes){ {provider: "google", url: "http://plus.google.com/+WilliamShatner"} }

        it "parses username correctly" do
          expect(parser.username).to eq "WilliamShatner"
        end
      end
    end
  end
end
