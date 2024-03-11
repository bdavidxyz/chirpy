---
title: My honest opinion about Hatchbox
author: david
date: 2024-02-22 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails,hotwire]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: My honest opinion about Hatchbox
---

## Context

I'm writing this article as a user, I'm not affiliated with the product or company. So it's an honest review. I'm used to Docker and Heroku mainly, so for me Hatchbox was a recent discovery (at the time I wrote this article).

## Should you try it?

Yes, I think so. This was the short answer 😬

Let's dive in.

## What is HatchboxIO?

[Hatchbox](https://hatchbox.io/) is a deployment platform for Ruby-on-Rails. If you prefer, it's a Heroku competitor.

With one major difference : you have to use it along a server like a Digital Ocean one, or equivalent.

## How easy it is compared to Heroku ?

It's a very similar user experience, but I find it even easier than Heroku. I didn't need to check the docs once.

Probably the most intimidating part is the fact that Hatchbox relies on external hosting (like Digital Ocean), whereas Heroku handles everything for you.

But Digital Ocean was click-and-forget (I've chosen a 6$ droplet), so was Hatchbox (cost $10 per month at the time of writing).

As far as I can remember, the only thing that I looked at for more than 10 seconds was how to bind the databases to my current app, but I think that was all.

That's for the deployment part.

For other things like running Rails console or locally a dump of the production database, everything is done through SSHing.

With Heroku you don't even have to SSH anything, it's done through the CLI mainly.

That being said, both options are very easy to use.

## How fast it is?

One of the most responsive webapp I've seen so far.

Even deployment doesn't takes long  - ok it was a simple webapp. But what a joy not to wait for minutes before the build is over.

## The strongest point of Hatchbox

The sweetest thing about Hatchbox is that you don't pay anything if you create one more app.

And it's also a lot cheaper than Heroku - you don't pay for every single featurette.

## The only weak part 

The only thing I don't like (and that's the only one) is that it is available only in Ruby-on-Rails. The UX is so easy that I would like to see it available for multiple languages and frameworks.

## One last word for Chris 

Maybe a small paragraph to thanks Chris Oliver, who created Hatchbox, for the incredible contribution to the Rails community, for so many years now.🙏

## Summary

Hatchbox is (so far) the best option, both in terms of pricing and UX, from junior to advanced Rails developers.

Probably advanced devops users will prefer something they own, like Kamal, but Hatchbox abstracts so many things nicely, that it still brings a lot of value IMHO.

For very beginner with programming I suggest starting from Heroku, then switching to something else.

