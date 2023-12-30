---
title: "Webpacker vs Sprockets , the battle is over"
author: david
date: 2021-04-01 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Webpacker vs Sprockets , the battle is over"
---

## 0. The ancient times : before Sprockets  

I wasn't in the Ruby-on-Rails industry at that time, so I asked other people [what was there](https://www.reddit.com/r/rails/comments/lfbomu/archeology_what_was_there_before_sprockets/). Surprisingly, the answer is : nothing. You just had to copy/paste JS or CSS inside the /public folder, thus the JS or CSS became immediately publicly available (hence the name). I guess you just had to reference the file from the relative path from the root URL and bam, you're done.  
  
I miss that time (even if I wasn't there). Everything was pretty straightforward. Standards and expectations were lower. Usability and performance too. Anyway what could be called the "not too bad" performance and "standard" usability is now a lot higher. And ability to build maintainable JS and CSS too. So unfortunately skipping the frontend tooling is no more an option.  
  
If you wanted *uglification* or *minification* you had to rely on your *own tooling*. Generally speaking, this is a pain point the Rails philosophy tries to avoid. If it's not inside the Rails default, "there's a gem for that", as the saying goes.  
  
## 1. Enters Sprockets  
  
Sprockets appeared in 2011 along with Rails 3.1.  
  
It allows (allowed) you to manage SCSS, JS minification, referencing images, fonts, and other kinds of frontend assets tasks. The drawback is that it is not much used outside the Ruby-on-Rails space. The main advantage is that it perfectly embraces the copy/paste simplicity seen above. You just had to copy/paste a JS file, put it into the /vendor directory, and magic happened. You could reference the file with a simple `// require mylib.js` into the main `application.js` file, and you were done. Same could be said for SCSS, and not much work for images and fonts.  
  
Maybe I'm a little too optimistic here. When you have to put these assets into production, you have to stack a pile of hacks.  
  
But at least in dev mode, things were quite clear.  
  
## 2. The raise of JavaScript tooling  
  
Then in the 2010's decade, JavaScript became THE language of the web, both for front- and back-end. Of course the number of available building tools became quite crazy. This where I find the Rails community amazing. Instead of diving into the next shiny tool, **they waited for the battle to be over, in order to pick the winner**.  
  
They could have integrated Bower or Brunch before - some devs tried. It was not that bad. But if you wanted to lower the risk and stay on the safe side of frontend assets management, you had to stick with Sprockets, and just look at others having fun.  
  
So once the building tools were standard enough and stable enough, the Rails contributors decided to give Webpack and Yarn a chance. They wrapped everything into a gem named webpacker, and wow ! The shiny, funny, productive tools (hello tree shaking, CSS purge, and so on) became immediately available to every Rails developer in their default stack.  
  
## 3. The first days of Webpacker  
  
Webpacker was out in [march 2017](https://github.com/rails/webpacker/releases/tag/v1.0.0)  
  
As often with a new tool, it may not be a good idea to use it into production from day 1. See [this article](https://www.codementor.io/@help/rails-with-webpack-not-for-everyone-feucqq83z) from early 2018. Thus I avoided webpack, until [march 2020](https://prathamesh.tech/2020/03/25/webpacker-5-0-released/), and the ability to manage multiple packs.  
  
This lets time to deploy platforms like Heroku to have better support for webpack(er), and all possible bugs to be referenced on reddit or stackoverflow.  
  
Sometimes, when a new technology arise, I like to dive in very quickly (like [Bootstrap v5](https://getbootstrap.com/docs/5.0/getting-started/introduction/), still in beta), but sometimes, it's better to wait, even if this waiting last for many years. Safety and stability first.  
  
## 4. The switch  
  
So I used Turbolinks only in my new rails project until march 2020, and avoided Webpacker.  
  
When I say "avoid", I mean : completely avoid. I can't see the point to have **2 different frontend asset managers to do the same job**.  
  
After Webpacker 5, I did all the contrary. I now use webpacker only. **I don't use Sprockets anymore**, However I left it installed for many reasons, as if I don't actually use it :  
  
- Rails itself expect Sprockets to be installed, so weird bug may occur because of its non-presence  
- Some gem relies on Sprockets  
- Deployment platform may expect Sprockets to be here  
  
## 5. Conclusion  
  
It's time to leave Sprockets.  
  
The story of Webpacker is why I love Rails. Innovation yes, but only once things are completely stable and mature. UX now is driving innovation a lot (the rise of Hotwire for Rails, or the incredible success of React for JavaScript), and we can profit from the power of tools that were initially outside the Rails scope.  
  
Fantastic !