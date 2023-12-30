---
title: Rails 8, unreleased features
author: david
date: 2022-05-23 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails 8, unreleased features
---

## Rails 8 : More confidence in existing tools  
  
Rails tend to anticipate the trends - which means how neat are the maintainers. ActionText is one example. Before Trix, let's face it, giving any non-techie user the ability to write content was quite costly - or painful. Nowadays however, there are better tools than Trix. Simple features like "please create a `<p></p>` paragraph for every new paragraph" are still not released after years of PRs and requests from the community. I know, Open Source is given for free, and we should acclaim maintainer first instead of complaining. So first, **a big thank you to all maintainers**. Now for the Rails team, we would see two viable options :  
  
* Make Trix stay on top of competition. Notably for SEO features and HTML compliance - `<p></p>` was just one example. But that would require tons of energy on only one tiny part of the Rails stack.
* Abandon Trix, and rely on the work of others.
  
We could be wrong of course, but at one point, we think that the second option seems more reasonable.
  
*Trix* was beating every other tool when it was released, but after a few years, maybe it's time to reconsider and finally use something widely adopted by the community.  
  
## Rails 8 : Active Authentication  
  
Maybe it should be the first paragraph, because it's probably one of most missing features amongst Rails devs. That's also true for our product (see the page [why it's time for better defaults](https://www.bootrails.com/why/#time-for-better-defaults), first bullet point). We can notice that most Rails projects use Devise, but this gem requires heavy hacks for corner cases. Which creates frustration. Moreover, authentication is always here, in any Rails app - I've never met any Rails app without it, so far. So making authentication here by default makes a lot of sense.  
  
**Hint** : Here at BootrAils we use what we consider the closest "default gem" for authentication : Rodauth. Here is a tutorial about [how to authenticate with Rodauth from scratch](https://www.bootrails.com/blog/rails-authentication-with-rodauth-an-elegant-gem/).  
  
## Rails 8 : another front-end manager ?  
  
We are a little bit joking here, since front-end management has moved a lot in the past years, after a decade of decent stability.  
  
They somehow tried to circumvent this problem by adding an extra layer on top of a choosable bundling tool.  
  
The problem is, it is still two different tools for CSS and JS, and these two cohabit with the old - but mature - Sprockets pipeline.  
  
As we said earlier, maybe it's time to rely on existing tools. Finally Sprockets wasn't widely used, and Webpack(er) was somehow complicated. However, the need for bundling is so high in the industry that _probably a better standard should exist somewhere_.  
  
At bootrAils we found that ViteJS was this tool (we wrote an entire article about [ViteJS and Rails](https://www.bootrails.com/blog/vitejs-rails-a-wonderful-combination/)), but it could be even better if there were a way to ask the community what do they prefer.  
  
## Change scaffolding, and align with Hotwire  
  
Scaffolding is the ability for a Ruby-on-Rails app to generate [Models, Views and Controller](https://www.bootrails.com/blog/ruby-on-rails-mvc/) automagically. The user enters only the type of each field of a model, then migration file, models, controllers, views, unit tests are generated.  
  
Since Hotwire is now in the place by default, these generators should be more aware of how Hotwire works. There is an attempt to glue Hotwire and scaffolding, in this <a href="https://github.com/jasonfb/hot-glue" target="_blank">Github repository named hot glue</a>, but this is not part of the official Rails project, as far as we know.  
  
  
## Better production defaults  
  
For every new Rails app, we have to tweak the `production.rb` defaults. Maybe it's a good thing after all, so that each developer is aware of which config will apply on its own application. In our humble opinion, such things as `force_ssl = true` (and a few others) should be a default.  
  
## From Rails 7 to Rails 8 : A clearer Roadmap ?  
  
What will be released in the next version of Rails is a mystery.  
  
From what we understand, Ruby-on-Rails roadmap is basically Basecamp roadmap. The good news is, they do neat, brilliant work, and they release some new products, making Rails shine a little bit more on every new version. Probably the "Hey" product allowed Hotwire to gain new adopters, and allowed Ruby-on-Rails to be the new trendy toy - _once again_.  
  
However it would be nice if the community was more involved in the Roadmap.  
  
  
## Rails 8 embeds some defaults  
  
It cost nothing to delete (deprecated) code - just press "del", but it cost a lot to write robust, tested code.  
  
As far as I can remember, in Rails 3, the landing page was already included in the project. All you had to do is to remove the landing page and build your own.  
  
It would be nice to have at least one controller, one view, one model, one migration, and a command to delete everything if this is not needed.  
  
But from our experience, each time you have to test or isolate a new concept, you have to create a new Rails app, with at least a controller and a home page.  
  
## Rails 8, Rails X : we need some hot-reloading that works out-of-the-box  
  
No matter which version of Rails we use, _we always need hot-reloading to work_. The problem is, it has never been a default feature of Rails, and surprisingly, it's not so often claimed by the community as a _de-facto_ feature.  
  
If you code with NextJS or EmberJS (or any JS framework actually), you never hit the F5 key to reload the browser every time you modify a (front-end related) file. It seems quite obvious nowadays, and making it work with _esbuild_ or _guard_ is still very tricky.  
  
**Side note** : This is something that works really well, if you use [ViteJS with Rails](https://www.bootrails.com/blog/vitejs-rails-a-wonderful-combination/).  
  
  
## Conclusion  
  
Ruby-on-Rails 8 is far from being released, and we are neither committers, nor part of the Rails team. But it's always good to take a step back, breathe, and think about what could be improved in the future.