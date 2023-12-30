---
title: "Rails without jQuery , a new journey has started"
author: david
date: 2021-03-08 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Rails without jQuery , a new journey has started"
---

## It's not about the size  
  
jQuery is not that big. A few dozen of KB are nothing compared to the high-definition background video the designer requires you to add on the landing page.  
  
However I understand the dev's frustration. Browsers are able to handle what jQuery does. Thus, using a 3rd party lib instead of a standard, native solution seems a "code smell" at first glance.  

  
## It's about habit  
  
The jquery API is very intuitive. And shared across the globe. Around 2014, as far as I can remember, it was used by about 90% of the websites (I can't remember the source, sorry).  
  
The plugin ecosystem was extremely wide.  
  
At that point, I really wonder why jQuery was not seen as a web standard, and directly integrated into browsers. W3C could have decided it years ago.  
  
Anyway, now, it's too late. Almost everything can be another way, just by following standard web API.  

  
## The problem  
  
Now web browser comes with an API that is :  
- a lot more verbose  
- a lot less intuitive  
  
Let's take an example :

```javascript
// jQuery
$('.button').click(function() {
  // code…
})

// JavaScript equivalent
[].forEach.call(document.querySelectorAll('.button'), function(el) {
  el.addEventListener('click', function() {
    // code…
  })
})
```

- You can code the jQuery version "right now", with limited jQuery knowledge.  
- You can hardly write the JavaScript version without referring to a guide or cheat sheet.  
  
The ecosystem has evolved. I now often see tiny libraries that are shipped with ES6 only in mind. I already talked about Rails and Bootstrap, but even my favorite [accessibility lib](https://van11y.net/), originally built with jQuery, has now a vanillaJS alternative.  
  

## The solution  
  
Maybe it's time for Rails app to try to be entirely built without jQuery. I know, there are many apps (and devs) who already jumped into this "danger zone" a long time ago.  
  
This means more verbose JavaScript. On the other hand, the rise of [Hotwire](https://hotwire.dev/) means less JavaScript anyway.  
  
For the private admin backend, I still embed jQuery, where I feel that the need for performance and standardisation is not as important.