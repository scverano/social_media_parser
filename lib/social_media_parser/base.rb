module SocialMediaParser
  class Base
    attr_accessor :profile_attributes

    WHITELIST_PROVIDERS = ['twitter', 'facebook', 'pinterest', 'instagram', 'github']
    FACEBOOK_URL_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?/

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
      if whitelist_provider?
        validate_url || provider_url_from_username_or_url
      else
        validate_url
      end
    end

    def username
      if whitelist_provider?
        if validate_url
          username_from_url
        else
          profile_attributes[:username] || profile_attributes[:url]
        end
      end
    end

    def provider
      profile_attributes[:provider].downcase if whitelist_provider?
    end

    private

    def whitelist_provider?
      WHITELIST_PROVIDERS.include? profile_attributes[:provider]
    end

    def validate_url
      uri = URI.parse(profile_attributes[:url])
      return uri.to_s if %w(http https).include?(uri.scheme)
      return "http://#{profile_attributes[:url]}" if PublicSuffix.valid?(URI.parse("http://#{profile_attributes[:url]}").host)
    rescue URI::BadURIError, URI::InvalidURIError
      nil
    end

    def provider_url_from_username_or_url
      "https://#{provider}.com/#{profile_attributes[:username] || profile_attributes[:url]}"
    end

    def username_from_url
      case provider
      when 'twitter', 'pinterest', 'instagram', 'github'
        URI.parse(validate_url).path.split("/")[1]
      when 'facebook'
        FACEBOOK_URL_REGEX.match(validate_url)[1]
      end
    end
  end
end
