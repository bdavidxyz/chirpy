---
title: render partial vs render right now with Rails 7
author: david
date: 2024-02-22 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails,hotwire]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: render partial vs render right now with Rails 7
---


    <%= render 'buy_now', text: 'Buy Rails edition' %>
    <%= render partial: 'buy_now', locals: {text: 'Buy now for 99€'} %>
