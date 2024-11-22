---
title: Rails 7, a preview
review: deprecated
author: david
date: 2021-05-08 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%207%20%20a%20preview,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails 7, a preview
---

## Hot reloading just works™  
  
Hot reloading means "auto-refreshing the browser when the developer modifies a file".  
  
It's 2021, now all web frameworks (at least in the JavaScript space) have hot-reloading that just works out of the box. Without any special config. Without any weird bug. For Rails, this is not yet the case. JS and SCSS modules are hot-reloaded through webpacker. It works, so-so. But all HTML files (through ERB/HAML templates) are not (yet) hot-reloaded.  
  
I put this on the top of the letter, like children would for their most wanted gift. 🎁  
  
## Trix is SEO ready  
  
Trix is an HTML editor, made by the Rails team. I found that investigating this field was a super idea. I was surprised not so long ago, that editing HTML was so painful - there are many possibilities, but none of them could be plugged out of the box.  
  
I realize that's the second time that I write "out-of-the-box"... Maybe because we love the Rails magic precisely because of its ability to provide things that work without thinking about it :)  
  
Trix is missing some features like Hn (HTML headings : h1, h2, etc), and ability to view source code. Since Rails embraces the web standards from the beginning, it would be super cool to have this kind of feature.  
  
Waiting for Trix to be a more complete tool, I use the fantastic [Easy Markdown Editor](https://easy-markdown-editor.tk/).  
  
## "Rails new" is interactive  
  
There's a problem with "The Rails Way" : nobody agrees about what that is.  
  
- Testing ? Default is Minitest, but RSpec is a lot more used by the community.  
- JavaScript ? Too many frameworks.  
- Concerns ? Standards yes, but disputed.  
  
I see this as both a richness and a pain.  
  
Anyway, one of the powerful Rails features is to make choices for us, but when the number of choices explodes, this special philosophy may become a weakness.  
  
So a cool feature would be an interactive "rails new" mode. There's already a [minimalistic way](https://bootrails.com/blog/rails-new-options) to create a Rails application.  
  
This feature would start from this minimalistic way, and then ask questions to the developer.  
  
**What kind of authentication would you like ?** Devise/Clearance/None  
**What kind of JS Framework would you like ?** React/Vue/None  
**What kind of admin backend would you like ?** administrate/madmin/none  
  
And so on.  
  
  
## ActiveDeploy is born  
  
It's an [old debate](https://medium.com/@wintermeyer/https-medium-com-wintermeyer-rails-needs-active-deployment-65c207858c3) in the Rails community, but I still find it very relevant in 2021. The goal of Rails - outside mentioned magic - is to spend less time on wiring things together. And more time on added value. I can see no value in wiring a standard Linux with a standard Rails app.  
  
Heroku is still my default choice, and now we can choose between many Heroku-like platforms. But there is still no standard way to deploy it on a regular Linux machine. Maybe a default docker file and workflow ?  
  
  
## Concerns are softly deprecated, in favor of PORO  
  
Concerns are not entirely embraced by the community. Given the added complexity and the number of developers who abandoned it, I only use PORO for my Service Object. They are easy to call, easy to read, easy to understand, easy to test, etc.  
  
They are probably not included in the default Rails stack for a reason : they are too simple. Just Ruby objects. Any framework is meant to provide classes and objects that will be called *later on* by the framework.  
  
However, it would be cool if the Rails team promotes the "Service Object" pattern, by adding a "services" folder in the root of the app (for shared services), and a "services" folder everywhere the "concerns" folder also appears.  
  
## An official showcase list is maintained by the core team  
  
I found a great [showcase](https://turbo-showcase.herokuapp.com/) of Hotwire here recently. Somehow the Bootstrap v5 team also have a list of officially supported themes.  
  
That would be nice if the Rails contributors maintain a list of projects that match well (or quite well) the Rails philosophy.  
  
I also found this kind of list [here](https://github.com/asyraffff/Open-Source-Ruby-and-Rails-Apps) on GitHub.  
  
## Webpack(er) handle all the frontend assets

There's no point to keep two different tools to do the one same job ([Webpacker and Sprockets](https://bootrails.com/blog/webpacker-vs-sprockets)), so the newer one is now entirely functional, and the older one is kept only for backward compatibility reasons. 

Sprockets is not anymore used for any new project started with the "Rails new" command, and Webpacker can now handle images, fonts, CSS, JS, and any other kind of frontend assets *right from the beginning*.

  
## System tests are softly deprecated, in favor of Cypress-based gem  
  
Rails value an integrated system.  
  
Thus, in my humble opinion, integration and system tests should be first-class citizens in Rails.  
  
The problem is, having a system test that works is *not* magic, and *not* easy. It requires [a lot of configuration](https://blog.appsignal.com/2020/02/12/getting-started-with-system-tests-in-ruby-with-minitest.html), in order to have not-too-brittle tests.  
  
There's already a tool that perfectly handles this kind of test : Cypress. Why not a gem based on Cypress, that would replace entirely the default system tests stack ? So far, I am very happy with this gem : [https://github.com/testdouble/cypress-rails/](https://github.com/testdouble/cypress-rails/)  
  
## Partials are softly deprecated, in favor of view_components  
  
Testing in Rails is a big thing. Rails provide a lot of ways to test your app, right from day 1.  
  
In these days where UX drives innovation a lot (Hotwire do you hear me), there is no way to unit test the views by default.  
  
Partials however is a step in the right direction. They are testable through RSpec - with Minitest, you have to play directly with ERB.  
  
Now there is this incredible gem named [view_component](https://github.com/github/view_component), who pushes the concept more far away, and gives us independent, fast, testable views. Why not simply rely on the work of Github devs and merge the gem natively into Rails ?  
  
## GitHub Actions or CircleCI already works  
  
Well, the title is pretty self-explanatory. I find it tedious to rebuild a full continuous integration file for each new Rails project, especially since the rise of docker-based configuration for Github Actions of CircleCI.  
  
## Conclusion  
  
A big thank you to Rails core team. All this work is given to all users for free.  
  
This is a very personal list, I'm not sure if the points listed are shared by other members of the community, so don't be afraid to heavily criticize.