require 'social_media_parser/base'

module SocialMediaParser
  def self.parse(profile_attributes)
    Base.new(symbolize_keys(profile_attributes))
  end

  private

  def self.symbolize_keys(hash)
    new_hash = Hash.new
    hash.each{|k,v| new_hash[k.to_sym] = v}
    new_hash
  end
end
