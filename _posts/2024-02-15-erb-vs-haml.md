---
title: Ruby-on-Rails ERB vs HAML
author: david
date: 2024-02-15 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby-on-Rails%20ERB%20vs%20HAML,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20shamelessly%20opinionated%20article,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: ERB vs HAML
---


This is an opinionated article about ERB and HAML with Rails. Let's compare each other and pick a winner.

## Use case

In the Ruby-on-Rails word, they are known as templating languages. In the MVC concept, they represent "the View". Both are here to output HTML. 

## Example

Examples worth a thousand words, so here are two examples, one with ERB, the other with HAML. Both are strictly equivalent. I tried to put different kinds of concepts in order to highlight various problems : create variables, run ruby code, inline style, condition, loop, etc.

ERB template file

```erb
<% v = run_some_ruby_code %>

<div id="main" style="margin-left: 0">

  <div class="left column">
    <h2>Welcome to the library</h2>
    
  <% books.each_with_index do |book, indx| %>
      <% if indx > 0 %>
      <p><%= book.title %></p>
    <% end %>
  <% end %>
  </div>


  <div class="right column">
    <%= render "shared/sidebar" %>
  </div>

</div>
```

Is equivalent to this HAML template file :

```haml
- v = run_some_ruby_code
#main{style: "margin-left: 0"}
  .left.column
    %h2 Welcome to the library
    - books.each_with_index do |book, indx|
      - if indx > 0
        %p= book.title
  .right.column
    = render "shared/sidebar"
```

## ERB 

 - Plain HTML is still valid, so copy/pasting from other websites is not a problem
 - Indent as you like : maybe seen as an advantage : if you'd like to indent it the way you want. Could also be seen as a problem : bad indentation still works...
 - Standard with the Rails default stack : that mean more standardisation : better IDE support, legacy app may use it more, and a lowest barrier entry 

## HAML 

 - HAML is a lot less verbose - this is the main *unfair advantage*  of HAML.
 - HAML must be correctly indented. Sometimes the indentation is not as intuitive as it should. So it's not *so* cool.
 - HAML is also not very intuitive for corner cases (javascript tags, inline CSS...). In this case, you have to use an external online tool.
 - Added as a gem, i.e. not included in a default Rails application
 - Known as slower than ERB  - I didn't notice any practical difference though.

## And the winner is

ERB.

I've used both and I have to say HAML has one very big advantage  : a lot less verbosity. This is very handy for large template files. But large template files are not so frequent in an application if you properly cut them into small pieces - partial or view_components. 

So now HAML's big one advantage doesn't outweigh the sum of its disadvantages : hard to copy/paste from examples, and tricky corner cases notably.
