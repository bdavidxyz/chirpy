---
title: How to rename a Rails app
author: david
date: 2022-03-03 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20rename%20a%20Rails%20app,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to rename a Rails app
---

## How the Rails your app name was defined

First, the name of your Rails app comes from the "rails new myapp" command. In this example, "myapp" is the name of your Rails app.

 - It creates a folder named "myapp" and put all the default files and directories inside,
 - The main module of the application (under config/application.rb) is named "Myapp" (beware of the first capitalized letter)
 - Some files contains the word "myapp" - like package.json, but I won't list all files here, it depends on what version of Rails and what options you passed to the "rails new" command. Just use the "search and replace" command of your editor.

## You will rename occurrences at least 3 times

 - rename the top folder,
 - rename the module under config/application.rb
 - do a find all/replace all for all the remaining occurrences.

Warning, if the original name was too generic, like "rails" or "app", there could be occurrences that do not concern your app's name.

Pay extra attention to the case. Ruby is case-sensitive, so don't go too fast when replacing occurrences.

## Conclusion

Renaming a Rails app is not an anxious task. Just take time to change occurrences with care, it will work seamlessly.

And, of course, after that, run your test suite ;)