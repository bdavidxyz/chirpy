---
title: Tailwind and Ruby-on-Rails starter kit
author: david
date: 2024-02-01 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby-on-Rails%20ERB%20vs%20HAML,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20shamelessly%20opinionated%20article,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Tailwind and Ruby-on-Rails starter kit
---


# Tailwind and Ruby-on-Rails starter kit

Today I'm releasing a brand new Ruby-on-Rails starter kit.

Yes, I know, starter kits are all the rage nowadays, and there are already established free and commercial products, in the Ruby area.

And in almost all other languages too.

So why the need of anything else?

## Bottleneck and motivation

I love the Rails stack for 

* The incredible short-term productivity
* The long-term stability
* The ability to push the tool in _any_ direction ("there's always a gem for that")

> You can bring to life any _functionality_ you want with a Rails-like framework.

Same can ot be said for the UI. **No**, I'm not talking about JS tools or communication with API. 

And **yes**, I'm aware of Hotwire.

But I'm talking about UI design.

## A long time ago, Bootstrap was the thing

For a long time, Bootstrap was (kind of) "Rails way" of making decent UI design. You had plethora of themes on the market, which lead to new problems :

 - You were sticked to the Bootstrap version
 - You were sticked to Bootstrap predefined classes (or scss variables)
 - You still had to make custom classes
 - It was hard to push the theme in one direction or another 
 - None of theme was built on default Bootstrap theme, which make the personality of the webapp unable to support any heavy lifting.

## Then, Tailwind

I love Tailwind because of


* (almost only) Finely sliced utility-class 
* Massive adoption (it helps!)
* Shared vocabulary about classes, whatever the project is, so no surprise for new devs in the team
* Agnostic to the actual design. It can be changed through configuration.
* Basically, zero CSS file
* Its ability to tackle corner cases (google around the "bailwind gap") without any additional file.
kle corner cases (google around the "bailwind gap") without any additional file.

## If Tailwind is the Ruby part of CSS, what is the Rails part ?

Like Ruby is good fundation for Rails, Tailwind is the good fundation for a more useful UI Kit.

In the CSS world, you don't talk about framework, you talk about "UI Kit", but (for me) it's the same idea. You start from a shared vocabulary (ways to define classes and methods for Ruby, ways to define CSS classes for Tailwind), and, from there, you give to the developer _something actually useful to deliver real-word, classic feature_.

In Rails, a Ruby method is not a functionality, whereas file upload is.

With Tailwind, a button is not a functionality, whereas a login screen is.

## How should a Tailwind UI Kit look like ?

In my humble opinion (as a Ruby-on-Rails developer), this is how a Tailwind UI Kit should look like :

- Classics like defining buttons, typography, forms (_they all do that_)
- Dynamic components like navbar or spinners
- Reusable blocks like featurettes, footer, testimonials, etc 
- Prebuild pages like "Home Page" and "Admin Dashboard"
- A design system that is quite complete, neutral tone, and easy to customise and share with designer.
- A large open-source part
- A good focus on a11y, in order to treat all our user with the same respect
- It should be still very active with frequent updates
- It should be *as big as possible* in order to allow the dev to tackle *any* weird design case - often by combining existing parts quoted above.

## And the winner is...

Flowbite.

Sorry to quote a commercial product, I have no affiliation (at the time of writing) outside being a happy user.

I know that developers look suspiciously at commercial products, but with marketing or designing tools you never reach the power and beauty of dev tools without paying a fee.

## Back to the starter kit

I think there is space for any new starter kit, especially if we combine the _classic features of a starter kit_ with _all the design possibilities of a UI Kit_