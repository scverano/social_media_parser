require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Google < Base
      URL_REGEX = /(?:(?:http|https):\/\/)plus.google.com\/?(?:u\/\d{1,}\/|)(?:\+|)([\w\-\.\%]{1,})/i

      def provider
        'google'
      end

      def url
        return url_from_attributes if url_from_attributes
        if username
          if Float(username)
            "https://plus.google.com/#{username}"
          end
        end
      rescue ArgumentError
        "https://plus.google.com/+#{username}"
      end

      private

      def parse_username_from_url
        URL_REGEX.match(url_from_attributes).to_a[1]
      end
    end
  end
end
