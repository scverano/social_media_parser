require 'social_media_parser/base'

module SocialMediaParser
  def self.parse(profile_attributes)
    Base.new(profile_attributes)
  end
end
