require 'social_media_parser/provider/base'

module SocialMediaParser
  module Provider
    class Github < Base

      def provider
        'github'
      end
    end
  end
end
