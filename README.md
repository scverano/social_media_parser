# SocialMediaParser

Parse social media attributes from url or construct url from attributes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'social_media_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install social_media_parser

## Usage

```
parser = SocialMediaParser.parse "https://www.facebook.com/teamcoco"
=> #<SocialMediaParser::SocialMedia::Facebook:0x007fe014ef0f78 @url="https://www.facebook.com/teamcoco">

parser.username
=> "teamcoco"

parser.provider
=> "facebook"

parser.url
=> "https://www.facebook.com/teamcoco"
```

`SocialMediaParser#parse` accepts either a url string or a hash, that accepts

```
{username: "teamcoco", provider: "facebook", url: "https://www.facebook.com/teamcoco", url_or_username: "teamcoco"}
```

The `url_or_username` option can be used when you're not sure of the input, like the screenshot below for instance. This gem is built to take user input directly.

![screen shot 2014-09-06 at 21 49 51](https://cloud.githubusercontent.com/assets/28260/4176355/4ea9524a-35ff-11e4-86e2-27407beef42c.png)


If the input provided isn't enough for SocialMediaParser to figure out which provider it is, it returns a `SocialMediaParser::Link` object instead.

```
link = SocialMediaParser.parse "www.ruby-lang.org/en/"
=> #<SocialMediaParser::Link:0x007fe014fd8350 @url="https://www.ruby-lang.org/en/">

link.url
=> "http://www.ruby-lang.org/en/"
```

The `url` method will always return a clean url, prepending http schema if needed and validating the top domain, using public_suffix.
