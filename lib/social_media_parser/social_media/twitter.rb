require 'social_media_parser/social_media/provider'

module SocialMediaParser
  module SocialMedia
    class Twitter < Provider
      URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?twitter.com\/(?:(?:\w)*#!\/)?(\w*)/i

      def provider
        'twitter'
      end

      private

      def parse_username_from_url
        URL_REGEX.match(url_from_attributes).to_a[1]
      end
    end
  end
end
