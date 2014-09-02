require 'social_media_parser/link'

module SocialMediaParser
  module SocialMedia
    class Base < ::SocialMediaParser::Link

      def username
        return @username if @username
        if @url_or_username and !valid_url_format(@url_or_username)
          @url_or_username
        elsif url_from_attributes
          parse_username_from_url
        end
      end

      def url
        return url_from_attributes if url_from_attributes
        "https://www.#{provider}.com/#{username}"
      end

      def valid?
        @provider == provider or
        (username and URI.parse(url_from_attributes).host.match("#{provider}.com"))
      end

      private

      # Common social media url format, like https://www.twitter.com/teamcoco
      # Overwrite this in subclasses when social media url formatting
      # doesn't look like this
      def parse_username_from_url
        URI.parse(url_from_attributes).path.split("/")[1]
      end

      def url_from_attributes
        return valid_url_format(@url) if valid_url_format(@url)
        valid_url_format(@url_or_username) if valid_url_format(@url_or_username)
      end
    end
  end
end
