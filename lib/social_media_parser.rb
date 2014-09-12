require 'uri'
Dir[File.join(File.dirname(__FILE__), 'social_media_parser', 'provider', '*.rb')].each {|file| require file }

module SocialMediaParser
  def self.parse(attrs)
    if attrs.is_a? String
      return parse(url: attrs)
    end
    Provider::Base.parse(attrs)
  end
end
