---
title: How to encode an URL String in Ruby
author: david
date: 2024-01-25 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20URL%20encode%20a%20String%20in%20Ruby,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:2024%20edition,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: How to encode an URL String in Ruby
---

# How to encode an URL String in Ruby (2024 edition)

## Short answer, encoding a Ruby String

2024 edition is :

```ruby
URI::Parser.new.escape(my_url_string)
```

There's already a full <a href="https://stackoverflow.com/questions/6714196/how-to-url-encode-a-string-in-ruby" target="_blank">stackoverflow question</a> about this, but it seems that from Ruby 3, the only working version (without heavy tweaks) is the one described above.

Full example :

```ruby
require 'uri'

my_string = "hello world"
my_url_string = "https://somedomain.com?word=#{my_string}"
URI::Parser.new.escape(my_url_string)

# => "https://somedomain.com?word=hello%20world"

```

## Corner case : unescaped characters

When you try to pass a quote mark however, this doesn't work :

```ruby
require 'uri'

my_string = "hello?world"
my_url_string = "https://somedomain.com?word=#{my_string}"
URI::Parser.new.escape(my_url_string)

# => "https://somedomain.com?word=hello?world"
```

This requires a little hack `.gsub('?', '%3F')`

```ruby
require 'uri'

my_string = "hello?world"
my_url_string = "https://somedomain.com?word=#{my_string.gsub('?', '%3F')}"
URI::Parser.new.escape(my_url_string)

# => "https://somedomain.com?word=hello%253Fworld"
```

Why the little hack ? Well I didn't take time to take a deep dive into the `escape` method, however, I suppose that given the fact that the quote mark is already part of a regular URL (it's a delimiter for the query string), this character is not encoded.

So let's push this assumption by trying to encode `://` (I left this part as an exercice for you:)

...

Ok they are not encoded. Which leads me to the last paragraph.


## Robustness of URL String encoding in Ruby

I tried some other methods, but this one is definetely the one which works right now. I deliberately mentioned the year in the title of the topic, because I'm not fully sure this answer will be still valid in say, 2 or 3 years, but as of now, it's definetly the most robust way I've found (so far).

Apart from characters that _actually_ belongs to a regular URL, I didn't found any other tricky stuff.

Depending of the use case, escaping those character might be a good or bad idea.

## Conclusion

Nothing special in this conclusion, I only hope you have won 5 minutes today because of this article :)

Best,

David.