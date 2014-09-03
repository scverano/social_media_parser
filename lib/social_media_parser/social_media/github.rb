require 'social_media_parser/social_media/provider'

module SocialMediaParser
  module SocialMedia
    class Github < Provider

      def provider
        'github'
      end
    end
  end
end
