---
title: How to use Rails flash messages
author: david
date: 2022-02-21 11:33:00 +0800
categories: [Rails]
tags: [Rails, Mailing, Tutorial]
pin: false
math: true
mermaid: true
image:
  path: v1702587216/newblog/action-mailer-tutorial/action_mailer_og.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to use Rails flash messages
---


## What are flash messages?

Flash messages are notifications and alerts that pop up in the interface of an application in order to communicate with the user and ease of interaction. Applications often apply flash messages to tell the user if the login was correct or to confirm the success of the action triggered by clicking a button. For example:

 - "You are logged in"
 - "Your profile has been updated"

**Side note :** At  [BootrAils](https://www.bootrails.com/) we use flash messages along with the . <a href="https://getbootstrap.com/docs/5.1/components/toasts/" target="_blank">Toasts components of Bootstrap</a>. More about this at the end of the article.

## Why should you use flash messages in your application?

Flash messages are a good UI/UX practice that is currently used by most applications as it is a great way to guide users through the interface and reduces uncertainty when the user triggers actions.

Flash messages encourage user autonomy and help them to identify errors.

For example, if the user is entering the wrong password or using a
format not supported by a field, the application is able to raise an
error alert and point the right way to proceed.

 - "Your password is wrong, please try again"
 - "Please enter at least 50 characters to post your review"

Using flash messages is also an asset when giving support to the user, as it is easy for support agents to ask the user where they find themselves in the interface and what messages they are receiving.

The advantages of applying notifications in an interface are clear and add value in different ways. Moreover, flash messages are very easy to integrate and maintain from a developing point of view. However, when implementing the notification strategy in an application, we need to be careful to not generate too many messages. That would add complexity to the code and create a sensation of user spamming.

## Types of flash messages

On the basis of all flash messages being notifications, we can
understand the different types of flash messages as the different
intentions of a message. By default, Ruby on Rails provides two types of flash messages, `[:notice]` and `[:alert]`. Hence, we can use notice messages to send the user little pieces of information and confirmations, and alert messages to raise errors.

If you need to add further types of message intentions in order to make your code more clear and add styling options, it is also possible with Rails. You just need to add them to the Application Controller as per below and the flash method will integrate them:

```ruby
class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success
end
```

## How to implement flash messages with Ruby on Rails

Integrating flash messages with Ruby on Rails is very easy as you just need to use the flash helper method.

Flash messages are included in the methods of the different controllers of an application. You just need to call flash followed by the type of message and the content as a string. For example, if you want to confirm that the information of the profile has been updated you just have to do as per below in the specific method of the User Controller:

```ruby
class UserController < ApplicationController
  def update
    /* some code before */
    if @user.update
      flash[:notice] = "Your profile has been updated."
    end
    /* some other code after */
  end
end
````

## Rendering and styling flash messages

Following the MVC pattern logic of the Rails application, the controller is responsible for the logic of the interface. Hence, after adding flash messages to controllers, we need to display them in the different views of the application.

We could go to each view of our application and render the different types of messages. As the display of messages happens after a user has been redirected to a page or the page has reload, the following code is normally added on top of the view:

```erb
<% flash.each do |type, msg| %>
  <div>
    <%= msg %>
  </div>
<% end %>
```

This proceeding is accepted, however, it is not scalable for large-size applications and will make your code not DRY. The most effective way to render flash messages is by creating a shared file and render it in the body of the application view file `application.html.erb`:

```erb
<%= render 'shared/flashes' %\>
```

Meanwhile, we have to create a shared file in the shared folder of our views following the convention syntax `flashes.html.erb`. 

The goal of this file is to loop through all flash messages attending to its nature (alert, notice, info, success, etc.).

At this point, we are also able to style the notifications in the
application. It makes sense that a notification message has a different style than an error message right? `[:notice]` and `[:info]` messages are normally styled smoother and blend with the application view as we do not want to stress the user. 

While `[:alert]` and `[:error]` messages are much more eye-catching and tend to use red or yellow bright colours.

You can add different classes and work on the related `.scss` file to style the messages in your application or you can use libraries such as Bootstrap that provide notification components to style your flash messages. The Bootstrap alerts component offers different styles based on the intention of the message (primary, secondary, success, danger, warning, info, light and dark). It also has the option to easily add a dismissal button (highly recommended to improve the UI/UX of an
interface), links inside your string content to redirect the user and
content divisors to include additional information sections.

Below, and to conclude, you will find an example of a shared flash file which loops and displays the different flash messages and uses bootstrap to style the notice and alert notifications:

```erb
<% if notice %>
  <div class="alert alert-info alert-dismissible fade show m-1" role="alert">
    <%= notice %>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
<% end %>

<% if alert %>
  <div class="alert alert-warning alert-dismissible fade show m-1" role="alert">
    <%= alert %>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
<% end %>
```

## How we use flash messages with BootrAils

Here is how a flash message is rendered : 

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:70%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1651239408/rails/flashmsg.png" loading="lazy" alt="flash message">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:70%">flash message</figcaption>  
</figure>  

You can see on the top that the user was successfully logged out.

**Side note** If you want more screenshots you can view them on the [home page](https://bootrails.com/).

We use a toast message, with a fixed position : no matter where the user is in the Y position, the user will still see this message. There is the ability to dismiss it with the cross, anyway, the message will disappear after a few seconds.

## Conclusion

Notifications are actually a very common feature on the Internet : give some clue to the user about what just happened. With Rails, a common, built-in way to achieve such a feature is a _flash message_.
