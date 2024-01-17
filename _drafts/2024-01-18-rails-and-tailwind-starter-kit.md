---
title: Tailwind and Ruby-on-Rails starter kit
author: david
date: 2024-01-18 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails, css]
pin: false
math: false
mermaid: false
image:
 path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Tailwind%20and%20Ruby-on-Rails%20starter%20kit,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:Thanks%20to%20Flowbite,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
 alt: Tailwind and Ruby-on-Rails starter kit
---


Today I'm releasing a brand new Ruby-on-Rails starter kit.

Free and open-source, so far :

<a href="https://github.com/bdavidxyz/tailstart" target="_blank">https://github.com/bdavidxyz/tailstart</a>

Yes, I know, starter kits are all the rage nowadays, and there are already established free and commercial products in the Ruby area. And in almost all other languages too.

So why the need for anything else?

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
- None of the themes was built on the default Bootstrap theme, which made the personality of the webapp unable to support any heavy lifting.

## Then, Tailwind

I love Tailwind because of


* (almost only) Finely sliced utility-class 
* Massive adoption (it helps!)
* Shared vocabulary about classes, whatever the project is, so no surprise for new devs in the team
* Agnostic to the actual design. It can be changed through configuration
* Basically zero CSS file
* Its ability to tackle corner cases (google around the "bailwind gap") without any additional file.

> IMHO, Tailwind is now the closest CSS tool that matches the "<a href="https://rubyonrails.org/doctrine" target="_blank">Rails way</a>" spirit. 
{: .prompt-tip }

## If Tailwind is the Ruby part of CSS, what is the Rails part ?

Like Ruby is good fundation for Rails, Tailwind is the good fundation for a more useful UI Kit.

In the CSS world, you don't talk about framework, you talk about "UI Kit", but (for me) it's the same idea. You start from a shared vocabulary (ways to define classes and methods for Ruby, ways to define CSS classes for Tailwind), and, from there, you give to the developer _something actually useful to deliver a real-word, classic feature_.

In Rails, a Ruby method is not a functionality, whereas file upload is.

With Tailwind, a button is not a functionality, whereas a login screen is.

So what should a "CSS framework" (or UI Kit) bring on the table?

## What should a Tailwind UI Kit look like ?

(Opinionated, as developer), here is how a Tailwind UI Kit should look like :

- Classics like defining buttons, typography, forms (_they all do that_)
- It should be still very active with frequent updates
- It should give extreme care to accessibility
- It should provide some dynamic components, at least the big classics like navbars or spinners
- Reusable blocks like featurettes, footer, testimonials, etc 
- Prebuild pages like "Home Page" and "Admin Dashboard"
- A design system that is quite complete, neutral tone, and easy to customise and share with the designer.
- A large open-source part

Lastly,

- It should be *as big as possible* in order to allow the dev to tackle *any* weird design case - often by combining existing parts quoted above.

## And the winner is...

Flowbite.

Note that I have no affiliation with them (at the time of writing) outside being a happy user.

The thing is, no free tool can reach that level of maturity. Even in the glorious day of Bootstrap.

I don't see it as an obstacle, since it's actually plain old Tailwind, there are no 3rd party dependencies (maybe outside the few JS components, but since they seamlessly integrate with the current Hotwire stack, I don't care much).

Moreover, they have a generous free tier, and they accepted to offer paying components that end up in this starter kit :gift:.

So yes, that's it, deep integrated Flowbite and Rails starter kit!

It's just the beginning, just clone the repo, give it a try, don't hesitate to ~~heavily criticize~~ give feedback.

<a href="https://github.com/bdavidxyz/tailstart" target="_blank">https://github.com/bdavidxyz/tailstart</a>

## Summary

Flowbite gives beautiful Tailwind design, **without anything that actually works**.

Rails gives endless functionalities, **without any UI design**.

I think there is still a tiny little room for the **best of both worlds**.
