---
title: Why is Ruby-on-Rails not more popular?
author: david
date: 2024-02-05 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails, opinion]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600%2Ch_836%2Cq_100/l_text:Karla_72_bold:Why%20is%20Ruby-on-Rails%20not%20*more*%20popular%3F%2Cco_rgb:ffe4e6%2Cc_fit%2Cw_1400%2Ch_240/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_180/l_text:Karla_48:A%20French%20baguette%20story%2Cco_rgb:ffe4e680%2Cc_fit%2Cw_1400/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_100/newblog/globals/bg_me.jpg
  alt: Why is Ruby-on-Rails not *more* popular?
---


## Intro

I once had a conversation with an American at breakfast.

He was eating a fresh French baguette, and seemed to be worried... his question finally was :

> Why is that so good?
{: .prompt-info } 

Why Americans do not make such kinds of bread was (for him) a mystery. Some cultural gap I guess?

Now let's go back to the Rails community. If Rails is so 

- incredible (which is true) 
- with such a strong and vibrant community (also true), 
- and an incredibly productive stack (again true!),

Finally,

> If Rails is **that** good, why is Rails not **more** popular nowadays?
{: .prompt-danger }


## UI driven development

From 2010's, most innovation was driven by UI development. 

Number of "component based" JS frameworks (Angular, Backbone...) popped up from every corner every single week.

I admit that React is able to tackle any UI State, which was a real pain before it appeared.

React has so much success (even nowadays) that arguing that it's not "only" a dev fashion, there was a cultural shift into the whole industry.

I'm not sure if it's an official quote, but :

> The past is easier to predict than future
{: .prompt-info }

**It could have been another story**. Maybe response time or productivity could have led the whole industry, but for whatever reason, it didn't happen that way.

It was UI first.

From 2015, it became bizarre to build an UI with a backend framework (maybe with some sprinkled vanillaJS and/or jQuery).

So probably all backend-based frameworks started to decline (or reached their plateau) from this point, this is not specific to Rails.

Now React-ers seems to rediscover that UI State is not *everything* inside a software, and they start to add useful things like SSR (with Next), backend (adding an /api route in the last version of Next), etc.

Anyway, my opinion is that tackling the UI state problem is what has driven the industry in the last decade. It could have been performance or (human) productivity, but no, so React took the lead. All frameworks that render HTML through plain old server-side templates (ERB for Rails) started to decline.

UI driven development led Rails to be less popular as it was.

## A world of endless possibilities

Rails reached its peak popularity around 2010. It was the best possibility to aggregate functionalities together without too much pain. During the following decade, tons of tools, SaaS, frameworks, startup kits of all kinds, as well as new languages with their own frameworks emerged. NoCode became a thing. LowCode too.


More possibilities emerge, the less room there is for Ruby - unless the market grows proportionally... but that hasn't been the case since, at the very least, the pandemic.

Now I can understand that learning a whole new language, a whole new stack sounds odds. Once you know about JS, you start the first 

And try to glue everything together, step by step.

It's not a very efficient approach, but I can understand. There are open-source tools like BlitzJS to help about it, or maybe some commercial starter kits. Or if you don't like React, maybe AdonisJS could help.



## Ruby

- Java is loved by universities and banks
- Python is loved by data scientists
- JS is known to anyone who has approached within 3 meters of a web page

Ruby suffers from lack of love, I guess - but is not the only language in this situation.

There's clearly a lack of adoption of the Ruby language (outside the Rails scope).

One advantage is that (almost) everybody that knows Ruby knows how to speak Rails, which makes life a lot easier.

But let's face it, the story could have been completely different if Rails was first written in, say, the Python language.

Ruby itself cause Rails not to be more widely adopted (I guess).


## Static types

Despite massive, universal adoption of JavaScript, both inside frontend and backend, the web community worked hard to find a way to be splitted apart : TypeScript. (Am I sarcastic?)

So it seems that having types is reassuring for most developers. I don't enjoy it much personally, especially in the FrontEnd, but after all if the community likes it then "let it be".

Rubyist don't chase types too much - despite the nice "Sorbet" attempt, classic Ruby remains not strongly typed, which newcomers may dislike.

## Economic recession

Probably the worst argument in the list, but still : there are less job in the IT market than before.

Less of everything.

So it also means less Rails. Alas.


## Not that bad, after all

On a French job board that I particularly enjoy, there are currently 78 jobs with the keyword "Ruby", and 747 with the keyword "JavaScript" - one tenth of the giganotosaurus JS is already a big thing.

But where I really worry about the lack of open junior positions, as well as the few interest by new startups to start anything with Rails.

So I'm not sure the future is bright.

Maybe, instead of UI-driven development, or Whatever-driven development, we will be back to computing essence : deliver features in the shortest amount of time with the best quality.

It's hard to see "no future" here.


## Conclusion

I usually don't write opinions, here was one. It's not easy to explain why Rails (or the Rails philosophy) is not more widely adopted, so trying to explore hypotheses is an enjoyable exercise.

