---
title: How to disable Turbo on specific links with Rails
author: david
date: 2024-02-22 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails,hotwire]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: How to disable Turbo on specific links with Rails
---



Turbo is precisely made to speed up page transition, but sometimes it's better to have a slower page transition - that works.

## Regular link with Ruby-on-Rails

Inside the views (by default, ERB template) you can write either :

```erb
<a href="/">Home</a>
```

Or

```erb
<%= link_to "Home", root_path %>
```

Be aware that by default,  **Turbo is enabled**, which means the home page (on the example) will not fully loaded : only elements of the body that are not the same than the current page will be replaced.

## Disable Turbo on a link

If this behaviour cause a bug, it's ok to sacrifice speed for stability. Just write :

```erb
<a href="/" data-turbo"false>Home</a>
```

Or

```erb
<%= link_to "Home", root_path, data: {turbo: false} %>
```

## Summary

Don't stress to much about Hotwire/Turbo. Quick hack is perfect if you need to deliver fast.