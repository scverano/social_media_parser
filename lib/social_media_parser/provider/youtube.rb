require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Youtube < Base
      URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?youtube\.com\/(?:user\/)([\w\-\.]{1,})/i

      def provider
        'youtube'
      end

      def url
        "https://www.youtube.com/user/#{username}"
      end

      private

      def parse_username_from_url
        URL_REGEX.match(url_from_attributes).to_a[1]
      end
    end
  end
end
