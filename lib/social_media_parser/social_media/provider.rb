require 'social_media_parser/link'

module SocialMediaParser
  module SocialMedia
    class Provider < ::SocialMediaParser::Link
      PROVIDERS = ['facebook', 'github', 'google', 'instagram', 'pinterest', 'twitter', 'youtube']

      def self.parse(attributes)
        if PROVIDERS.include? attributes[:provider]
          Object.const_get("SocialMediaParser").const_get("SocialMedia").const_get(attributes[:provider].capitalize).new(attributes)
        else
          PROVIDERS.map do |provider|
            Object.const_get("SocialMediaParser").const_get("SocialMedia").const_get(provider.capitalize).new(attributes)
          end.select(&:valid?).first or
          ::SocialMediaParser::Link.new(attributes)
        end
      end

      def username
        return @username if @username
        if @url_or_username and invalid_url_format? @url_or_username
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
      rescue URI::BadURIError, URI::InvalidURIError
        false
      end

      private

      # Common social media url format, like https://www.twitter.com/teamcoco
      # Overwrite this in subclasses when social media url formatting
      # doesn't look like this
      def parse_username_from_url
        URI.parse(url_from_attributes).path.split("/")[1]
      rescue URI::BadURIError, URI::InvalidURIError
        nil
      end
    end
  end
end
