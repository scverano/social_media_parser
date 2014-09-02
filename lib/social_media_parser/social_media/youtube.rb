require 'social_media_parser/social_media/provider'

module SocialMediaParser
  module SocialMedia
    class Youtube < Provider
      URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?youtube\.com\/(channel\/|user\/|)([\w\-\.]{1,})/i

      def provider
        'youtube'        
      end

      private

      def parse_username_from_url
        URL_REGEX.match(url_from_attributes).to_a[2]
      end
    end
  end
end
