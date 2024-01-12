---
title: Rails flash messages and usability
author: david
date: 2024-01-06 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20flash%20messages%20and%20usability,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:Are%20Rails%20flash%20messages%20designed%20for%20all%20users%3F,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Rails flash messages and usability
---

# Rails flash messages and usability

Flash message is a very old notion of Ruby-on-Rails. This article will be focused on the usability of these messages.

## Flash is a designer vocabulary

Flash message is not specific to Rails. Actually, if you google around "flash messages", you will show you some web designer examples.

Flash messages are these small feedback that the user receives, after an interaction with the web application.

It sounds like this :

 - "Log in successful"
 - "Errors on form"
 - "Item added to the cart"

It helps to make obvious what worked well, and what didn't.

## Flash messages, server-side : the easy part

On the server side, a flash message look like this :

```ruby
class LoginsController < ApplicationController
  def destroy
    session.delete(:current_user_id)
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url, status: :see_other
  end
end
```

How easy is that ?

 - "flash" object is well-named
 - "flash" object is given for free, inside each action of each controller
 - "flash" object can be used like a Hash to store the fabulous message
 - "flash" object can be a "notice" (neutral tone, for neutral message) or "alert" (scary tone, maybe an error message)
 - "flash" object is emptied after each request, making possible for the next request to display another message, related to the new action of the user

So nothing really fancy here. The flash message is easy to read, easy to write, easy to understand.

## Flash messages, frontend side, the complicated part

What's the problem with frontend part ? _There are multiple ways to render the fabulous message_.

Remember how easy it is on the server side.

Not here, alas.

I like this diagram :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1705051455/newblog/flash-and-ux/pyramid.png" loading="lazy" alt="Pyramid of intrusiveness for a flash message">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Pyramid of intrusiveness for a flash message</figcaption>  
</figure>  

Source : [Thirdwunder design alerts notifications](https://www.thirdwunder.com/blog/ui-ux-design-alerts-notifications/)

As you can see, there are tons of ways to render the flash message, but there are not all equals : they can be classified with their degree of intrusiveness.

 - A Spinner is less intrusive than a toast message (the small rectangle message in a corner of the screen)
 - A toast message is less intrusive than a HTML banner
 - A modal is super-intrusive

 Notice that "intrusive" doesn't mean "bad". It just correlated to the degree of dangerousness of the current action.

 Typically, if you try to delete a Github repository, you will probably have a User Experience that match the top of the pyramid, because you risk to loose data in a irreversible way.

## How do rails-y website solves this

From what I noticed, Rails developers don't care (much) about their flash message. It's mostly a set-and-forget setup.

Let's see some examples :

 - <a href="railsdev.com" target="_blank">railsdev.com</a>
Mostly solved with inserted divs on-the-fly. But not all of them. Error messages are rendered with a ViewComponent named ToastMessageComponent, who is probably, well, a toast message 😬😬😬. You can check any reference of flash message through the [opened-source code of railsdevs](https://github.com/search?q=repo%3Ajoemasilotti%2Frailsdevs.com%20flash&type=code).

 - <a href="hotrails.dev" target="_blank">hotrails.dev</a> Use toasts messages, the use of Hotwire is nicely described through a <a href="https://www.hotrails.dev/turbo-rails/flash-messages-hotwire" target="_blank">excellent   tutorial about flash messages</a>.

 - <a href="gorails.com" target="_blank">gorails.com</a> Some error messages are rendered as a on-top HTML banner, it is something you would probably do if you follow <a href="https://guides.rubyonrails.org/action_controller_overview.html#the-flash" target="_blank">official documentation about flash messages</a>
:

```erb
<html>
  <!-- <head/> -->
  <body>
    <% flash.each do |name, msg| -%>
      <%= content_tag :div, msg, class: name %>
    <% end -%>

    <!-- more content -->
  </body>
</html>
```

So as you can guess, a banner will be displayed on top of your website *each and every time* you need to give a feedback to your user.

It's both **bad** and **good**.

 - The good part is efficiency. You don't want to spend too much time on flash messages, given the amount of work on other parts of your application.
 - The bad one is the connection to your user. Will he/she see the banner on top of your website, if he/she filled a small form in the bottom of a page ? Maybe not.

Probably the best way to tackle this is to do like the rails-y websites, but also to take care about particular pages, where the banner or other global strategy will _not_ apply.

## Rails flash message and a11y issues

Since the raise of Single Page Application ~10 years ago, and Hotwire ~2 years ago, more and more elements appear dynamically on the page, making difficult for screen reader to read anything.

I wouldn't say that making flash message accessible is difficult, but, you need to take time to read the docs, and more importantly, to test it manually.

Rails devs love to talk (and code) about Rspec, Minitest, and simplecov, the thing is,

> Automated accessibility tools catch only around 20-25% of A11Y issues; the more interactive your webpage is, the fewer bugs it catches. 
{: .prompt-tip }

Extracted from this excellent <a href="https://www.smashingmagazine.com/2023/02/guide-accessible-form-validation/#required-fields" target="_blank">smashing magazine article about accessibility</a>, it also covers feedback messages - in the special case of form error, but still very useful.

There's also an excellent documentation about <a href="https://getbootstrap.com/docs/5.3/components/toasts/#accessibility" target="_blank">toast messages in the official Bootstrap documentation</a> - as if I prefer TailwindCSS by now, this article is more general-purpose anyway, so not bound to any CSS tool.

## Conclusion

To sum up, if I was starting a new Rails application nowadays, I would treat flash messages this way :

 - First, I would enrich the base vocabulary of the server-side flash message object. Remember, it only takes care about `:notice` and `:alert`. Most <a href="https://flowbite.com/docs/components/alerts/" target="_blank">Tailwind kits have 5 or more kind of message</a>. This will maximise the kind of messages you want to say to your user
 - Second, I will generalize the rendering on the frontend, like most rails-y website does. But, I will also take care about *not* using this strategy for particular case.
 - Third, I will embed accessibility from day one. This is not negotiable. I don't want to loose users, and I don't want to build things for the most lucky and healthy of us.

 Take care, health first then!

 David

