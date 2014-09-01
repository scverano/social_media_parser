require 'social_media_parser/social_media/common'

module SocialMediaParser
  module SocialMedia
    class Google < Common
      URL_REGEX = /(?:(?:http|https):\/\/)plus.google.com\/?(u\/\d{1,}\/|)(\+|)([\w\-\.]{1,})/i

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

      def valid?
        @provider.to_s.match(/google/) or
        (username and URI.parse(url_from_attributes).host.match("#{provider}.com"))
      end

      private

      def parse_username_from_url
        URL_REGEX.match(url_from_attributes).to_a[3]
      end
    end
  end
end
