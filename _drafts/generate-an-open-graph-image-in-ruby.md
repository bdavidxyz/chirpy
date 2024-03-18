---
title: Generate an open graph in Ruby
author: david
date: 2024-02-22 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: Generate an open graph in Ruby
---


## Og image and generation

Og image are the pictures that are displayed on social medias when you share a link. Automate their generation mean spend less time on plumbing, whereas maintaining a good emotional link to your readers.

BTW,  <a href="https://ogp.me/" target="_blank">Open Graph</a> is a protocol that enables social medias to read your content. You will often find the following meta in any web page :

```html
<html prefix="og: https://ogp.me/ns#">
<head>
<title>My super title</title>
<meta property="og:title" content="The Rock" />
<meta property="og:type" content="video.movie" />
<meta property="og:url" content="https://www.imdb.com/title/tt0117500/" />
<meta property="og:image" content="https://ia.media-imdb.com/images/rock.jpg" />
...
</head>
```

So here is a way to generate an actual og:image in Ruby, using Cloudinary.

Cloudinary is a service that allows you to store image in the cloud, and to add any random text above it.

## Generate og image method in Ruby

We will rely on cloudinary ability to generate layers on their image.

I generated this code by reading a blog article about the same topic, in JS (<a href="https://delba.dev/blog/next-blog-generate-og-image" target="_blank">og image generation in NextJS</a>)

```ruby
def generate_image_url(title, subtitle)
  base_url = "https://res.cloudinary.com/mycloudinaryid/image/upload"
  image_options = "/w_1600,h_836,q_100"

  title_text = "/l_text:Karla_72_bold:#{URI::Parser.new.escape(title)},co_rgb:ffe4e6,c_fit,w_1400,h_240"
  subtitle_text = "/l_text:Karla_48:#{URI::Parser.new.escape(subtitle)},co_rgb:ffe4e680,c_fit,w_1400"

  image_apply = "/fl_layer_apply,g_south_west,x_100,y_180"
  subtitle_apply = "/fl_layer_apply,g_south_west,x_100,y_100"

  background_image = "/path/to/myimage.jpg"

  final_url = "#{base_url}#{image_options}#{title_text}#{image_apply}#{subtitle_text}#{subtitle_apply}#{background_image}"

  return final_url.gsub('?', '%3F').gsub(',', '%2C')
end

```

All you have to do is to replace `mycloudinaryid` and `/path/to/myimage.jpg` by relevant content.

## Summary

Code example and cloudinary documentation should be self-speaking. You can this method in a Rails controller, or just inside a static website generator like Jekyll to get things done quickly.