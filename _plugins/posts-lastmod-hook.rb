#!/usr/bin/env ruby
#
# Need more robust website_url in many ways, see https://stackoverflow.com/a/69370394/2595513

require 'uri'

module Jekyll
  class WebsiteUrlTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
      tokens = tokens
    end

    def render(context)
      site = context.registers[:site]

      uri = URI.parse("#{site.config["url"]}#{site.config["baseurl"]}")

      str_uri_port = uri.port && uri.port != 80 && uri.port != 443 ? ":" + uri.port.to_s : ""
      websiteurl = uri.host + str_uri_port + uri.path
      websiteurl.prepend(uri.scheme + '://') if @text != "noprotocol"

      websiteurl.sub(/(\/)+$/,'')
    end
  end
end

Liquid::Template.register_tag('website_url', Jekyll::WebsiteUrlTag)