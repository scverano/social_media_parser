require 'public_suffix'

module SocialMediaParser
  class Base
    attr_accessor :profile_attributes

    WHITELIST_PROVIDERS = ['twitter', 'facebook', 'pinterest', 'instagram', 'github', 'youtube']
    FACEBOOK_URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-\.]*)?/
    YOUTUBE_URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?youtube\.com\/(channel\/|user\/|)([a-zA-Z0-9]{1,})/

    def initialize(profile_attributes)
      @profile_attributes = profile_attributes
    end

    def attributes
      {
        url: url,
        provider: provider,
        username: username,
      }
    end

    def url
      validate_url || profile_url_from_username_or_url
    end

    def username
      if whitelist_provider?
        username_from_url || username_from_attributes
      end
    end

    def provider
      profile_attributes[:provider].downcase if whitelist_provider?
    end

    private

    def whitelist_provider?
      if provider = profile_attributes[:provider]
        WHITELIST_PROVIDERS.include? provider.downcase
      end
    end

    def validate_url
      uri = URI.parse(url_from_attributes)
      return uri.to_s if %w(http https).include?(uri.scheme)
      return "http://#{url_from_attributes}" if PublicSuffix.valid?(URI.parse("http://#{url_from_attributes}").host)
    rescue URI::BadURIError, URI::InvalidURIError
      nil
    end

    def profile_url_from_username_or_url
      if username_from_attributes && whitelist_provider?
        "https://#{provider}.com/#{username_from_attributes}" 
      end
    end

    def url_from_attributes
      profile_attributes[:url] || profile_attributes[:url_or_username]
    end

    def username_from_attributes
      profile_attributes[:username] || profile_attributes[:url_or_username]
    end

    def username_from_url
      case provider
      when 'twitter', 'pinterest', 'instagram', 'github'
        URI.parse(validate_url).path.split("/")[1]
      when 'facebook'
        FACEBOOK_URL_REGEX.match(validate_url)[1]
      when 'youtube'
        YOUTUBE_URL_REGEX.match(validate_url)[2]
      end if validate_url
    end
  end
end
