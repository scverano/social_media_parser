require 'public_suffix'

module SocialMediaParser
  class Link
    attr_accessor :url, :url_or_username, :username, :provider

    def initialize(attrs)
      attrs.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def username
      nil
    end

    def provider
      nil
    end

    def url
      valid_url_format(@url)
    end

    def attributes
      {
        url: url,
        provider: provider,
        username: username,
      }
    end

    private

    def valid_url_format(url)
      uri = URI.parse(url)
      return uri.to_s if %w(http https).include?(uri.scheme)
      return "http://#{url}" if PublicSuffix.valid?(URI.parse("http://#{url}").host)
    rescue URI::BadURIError, URI::InvalidURIError
      nil
    end
  end
end
