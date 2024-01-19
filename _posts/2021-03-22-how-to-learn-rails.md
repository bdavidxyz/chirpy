---
title: How to learn Rails when you already have coding experience
author: david
date: 2021-03-22 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20learn%20Rails%20when%20you%20already%20have%20coding%20experience,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to learn Rails when you already have coding experience
---

<h2>Ruby is not complicated</h2>

<p>Ruby has both OOP and functional abilities. The only "tricky" part are blocks (see below). My advice here is to buy a book, or buy a course. The one of <a href="https://pragmaticstudio.com/courses/ruby">Nicole and Mike</a> is excellent (please note : I don't have any link with them outside being an happy customer;), the only thing I might add here is to practice daily, either by coding some daily exercises, either by entering in a "interactive ruby console", copy/paste some example, and see what happens. Docs are good when you have a question, but not when it's time to learn.  </p>

<p>The only tricky part of Ruby is this one : you can't directly use functions as first-class citizens, instead you have to rely on "blocks", "procs", or "lambda". Google them around.  </p>

<p>Everything else should look familiar if you already studied other languages.  </p>

<h2>Rails is easy, but thick</h2>

<p>Once you feel comfortable with the Ruby syntax, it's time to learn Rails. This time, you have a free official guide (<a href="https://guides.rubyonrails.org/">https://guides.rubyonrails.org/</a>), however, once again, my advice is to combine this guide with a paid book or <a href="https://pragmaticstudio.com/courses/rails">course</a>. I will same you times of hours and headaches.  </p>

<p>Note that all courses are as good as the time you are willing to spend on it. Make sure you have some free time in the next couple of weeks, because you will have to train every day, in order to grasp concepts. This is not something special to Rails though. The same applies when you learn guitar or Japanese (Sorry for Japanese readers here;). This will not apply to your entire career of course, but my 2 pennies here is to really dedicate a lot of time and energy at the beginning of the learning process.  </p>

<h2>Take special time to understand...</h2>

<h3>The request cycle</h3>

<p>Take time to understand how the request flows in your application. It explains how the controller works. Each HTTP happens in an independent context. Once you grab this, you're good enough with Rails... unless...  </p>

<h3>ActiveSupport</h3>

<p>ActiveSupport augments Ruby with intuitive, utility functions. These functions will avoid you to solve classical problems that others developers have already encountered. <a href="https://twitter.com/websebdev">Sebastien</a> just launched a new course about it, I <a href="https://bootrails.com/blog/rails-active-support">interviewed</a> him recently.  </p>

<h3>Lodash, Moment</h3>

<p>This is a little bit off-topic, since both are JS libraries, but since Rails is a full-stack framework, it's hard to bypass the frontend part. <a href="https://lodash.com/">Lodash</a> and <a href="https://momentjs.com/">Moment</a> are both utilities functions of the JavaScript world. Moment has only a focus on Date, whereas Lodash is more general purpose. I find them very underrated. People prefer to talk about the last new shiny JS framework. Anyway, we're here to talk about Rails :)  </p>

<h3>Service Objects</h3>

<p>There is a debate in the community about "where to put code that is related to your business". An intuitive way is to put them inside the controller, but this is not advised. The official Rails team put this code inside the Model (through Concerns), whereas a majority of Ruby dev do not like this practice.  </p>

<p>Instead, they use Service Objects. I find this notion a little bit mundane, since they only are (very often) plain old ruby objects - you will often find the acronym PORO. Google them around, there are tons of articles about this. You will even find some plugins (named gems) to tackle this problem, but try to stick with PORO as long as possible.  </p>

<h3>Testing</h3>

<p>If you already have some testing experience before, the same principles apply here. "Make some unit tests", "please code tests that run fast", etc, etc.  </p>

<p>However, there is a debate in the community about how to test it the right way. Each subtopic of the "testing topic" is itself subject to endless debates. For example, some like to initialize the context with "fixtures", whereas others like "factories" - I personally avoid both.  </p>

<p>My advice here is to <strong>always test a Rails app, at least at the highest possible level</strong> (functional or E2E testing), or you won't be able to upgrade your Rails, Ruby, and dependencies. For the short term it means not having access to nice features, over the long term it means security risks.  </p>

<h3>Deploying</h3>

<p>Deploy with Heroku as long as it doesn't cost much (you can even start deploying apps with 0$). There are tons of alternatives now, but my advice is to stick with the most well-known and well-established product. Then switch once you have more traffic.  </p>

<h2>Create tiny, but production-ready app</h2>

<p>I think it's hard to keep motivation high if you don't have some kind of short-term reward. Successful daily programming exercises can be one of them. Another is to launch a tiny, but real-world, production-ready app. Think about a news aggregator. Apart from listing links (and maybe some nice CSS styles), having something (really useful to others) build by yourself may not be too complicated.  </p>

<h2>Create YOUR side-project app</h2>

<p>I can not emphasize enough on this point. When I build <a href="http://bootrails.com/">bootrails</a>, I have time to :  </p>

<ul>
<li>study each dependencies deeply,<br></li>
<li>pay technical debt as soon as possible,<br></li>
<li>have 100% testing code coverage,<br></li>
<li>and so on.<br></li>
</ul>

<p>In a real-world, production app, you barely have time to do anything properly, nicely, and elegantly <strong>because of the time constraint</strong>.  </p>

<p>Having a side-project allows you to do things properly, which result in great satisfaction - for yourself, and soon for your boss and your teammates in your real-world project.  </p>

<h2>Use and abuse of the "rails new" command</h2>

<p>Testing a new gem, grabbing a new concept, debugging and isolating a problem, going back to basics. Each time I encounter one of these problems - and that's quite often - I use the "rails new" command.  </p>

<p>It creates a fresh new app, with standard gems, and green context (new, empty, un-conflicting database and tables).  </p>

<p>Don't be afraid of using it as often as needed. It won't bite. And the reward is huge. I was happy to discover that experienced Rails devs do that too.  </p>

<h2>Start with a minimalist Rails app</h2>

<p>Rails is quite old now (I mean : for the web industry). Which means you have a lot of new and old plugins each time you run the "rails new" command. Which is completely understandable for anyone who knows Rails from the beginning, but really hard to understand for a newcomer. So my advice is to always use the "rails new" command with the "--minimal" flag. It will install only the bare minimal plugins (known as gems) to have a Rails app that works.  </p>

<h2>Take time to study each gems</h2>

<p>One mistake I made was to just install Rails and code features, without taking time to study each default installed gem.  </p>

<h2>Deal and study compromises</h2>

<p>Nothing related to Rails here. You will find options and compromises all along your journey with Rails. I rarely find a "good" option, only one that is "not too bad".  </p>

<h2>Once you definitely know Rails</h2>

<p>Well, this should be an empty section, because there is no "after you know Rails". You never "know" Rails. Even after 5 years I feel very junior about Rails, actually the more I discover, the more I feel there is actually even more to discover. Thus I feel <a href="https://www.reddit.com/r/rails/comments/la6tfi/the_more_experienced_rails_dev_i_am_the_more/">even more junior</a>. </p>

<p>To conclude, here is a list of blog/people I follow :  </p>

<ul>
    <li>The <a href="https://www.reddit.com/r/rails/">reddit community</a>. People are very helpful.</li>
    <li>The <a href="https://rubyweekly.com/">Ruby Weekly</a>  newsletter.</li>
    <li><a href="https://blog.saeloun.com/">https://blog.saeloun.com/</a> that often blog and explain the last "nice to have" that was merged into Rails.</li>
    <li><a href="https://twitter.com/websebdev">Sebastien</a> has a lot of great Rails tips in its Twitter line.</li>
    <li>The <a href="rubyonrails-link.slack.com">Slack</a> community</li>
</ul>