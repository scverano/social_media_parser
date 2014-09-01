require 'social_media_parser/link'
Dir[File.join(File.dirname(__FILE__), 'social_media_parser', 'social_media', '*.rb')].each {|file| require file }

module SocialMediaParser
  PROVIDERS = ['facebook', 'github', 'google', 'instagram', 'pinterest', 'twitter', 'youtube']

  def self.parse(attrs)
    attrs = symbolize_keys attrs

    if provider = whitelist_provider(attrs[:provider])
      Object.const_get("SocialMediaParser").const_get("SocialMedia").const_get(provider.capitalize).new(attrs)
    else
      all_providers = PROVIDERS.map do |provider|
        Object.const_get("SocialMediaParser").const_get("SocialMedia").const_get(provider.capitalize).new(attrs)
      end
      all_providers.select(&:valid?).first or Link.new(attrs)
    end
  end

  def self.whitelist_provider(provider)
    provider.downcase if provider and PROVIDERS.include? provider.downcase
  end

  private

  def self.symbolize_keys(hash)
    new_hash = Hash.new
    hash.each{|k,v| new_hash[k.to_sym] = v}
    new_hash
  end
end
