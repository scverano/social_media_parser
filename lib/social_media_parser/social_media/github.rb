require 'social_media_parser/social_media/base'

module SocialMediaParser
  module SocialMedia
    class Github < Base

      def provider
        'github'
      end
    end
  end
end
