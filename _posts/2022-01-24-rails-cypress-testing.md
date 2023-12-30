---
title: Rails, Cypress, testing the whole stack is definitely easier
author: david
date: 2022-01-24 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails, Cypress, testing the whole stack is definitely easier
---

## 0. The origins : the Rails doctrine™  
  
At [BootrAils](https://bootrails.com), Cypress is already integrated, configured, with a few tests to cover and document the application. We find this tool very interesting because it matches one precise point of the Rails philosophy :  
  
> Value integrated system  
  
You can read the whole paragraph [here](https://rubyonrails.org/doctrine#integrated-systems).  
  
Which means, less boundaries, blurred lines between View, Controller and Model, despite being a MVC framework. This probably hurts for any newcomer to Rails.  
  
At the end of the day, you are more productive, even if layers *are not perfectly separated*.  
  
**Question** : Given that unit testing requires to test things in isolation, how do you test anything when layers are precisely **not** isolated ?  
  
Fortunately, some kind of testing are actually testing layers *together* :  
  
- integration testing  
- system testing  
- end-to-end testing  
  
All these kinds of testing are checking behavior from the outside.  
  
## 1. Testing Rails application from top to bottom : not so easy  
  
Before Cypress, testing the whole stack with Rails was not so satisfying. By "whole stack" we mean testing the whole running server, database, controllers, etc, **through the UI, like a regular user will do**. You had to glue multiple drivers, gem and libs together, and you ended with a not-so-well-stabilized testing screen suite. Selenium users know how complicated it is to achieve great work in this area.  
  
>  
  
<figure>  
<blockquote cite="https://www.codewithjason.com/rails-testing-hello-world-using-rspec-capybara/">  
<p>Unfortunately “the simplest possible Rails + RSpec + Capybara test” is still not particularly simple</p>  
</blockquote>  
<figcaption>—Jason Swett, <cite>“hello world” using RSpec and Capybara</cite></figcaption>  
</figure>  
  
  
## 2. Enter Cypress  
  
Cypress has the particularity *not to care* about the underlying tested screen. It doesn't matter if you use jQuery, Hotwire, AlpineJS or React in the front-end.  
  
Cypress brings a lot of positiveness amongst developers, at [BootrAils](https://bootrails.com) we particularly love it. Others too :  
  
<figure>  
<blockquote cite="https://www.reddit.com/r/rails/comments/ibenlh/comment/g1v5sfj/?utm_source=share&utm_medium=web2x&context=3">  
<p>We switched to cypress at work from capybara, and I will never be going back.</p>  
</blockquote>  
<figcaption>—found on Reddit. </figcaption>  
</figure>  
<figure>  
<blockquote cite="https://www.reddit.com/r/rails/comments/ibenlh/comment/g1vddv5/?utm_source=share&utm_medium=web2x&context=3">  
<p>It’s not that Capybara is dead, but the Cypress experience is just leaps better..</p>  
</blockquote>  
<figcaption>—found on Reddit too. </figcaption>  
</figure>  
  
  
Cypress replaces the need for Capybara.  
  
## 3. Cypress and Rails, a incredible wedding  
  
Now a very good news : integrating Cypress to Rails is *really* simple, because *there's already a gem for that*. Thanks to the amazing work of the [teamdouble](https://testdouble.com/) team. Their corresponding GitHub repository is [here](https://github.com/testdouble/cypress-rails).  
  
## 4. Tutorial, from scratch  
  
Let's install a fresh new Rails application, and test this beautiful gem.  
  
First, we are checking our seatbelts :  
  
```bash  
$> ruby -v  
ruby 3.0.0p0 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.11  
$> npm -v  
8.3.0 // you need at least version 7.1 here  
$> yarn -v  
1.22.10  
$> psql --version  
psql (PostgreSQL) 13.1 // let's use a production-ready database locally  
```  
  
Then, we create a bare Rails application :  
  
```bash  
mkdir rails-with-cypress && cd rails-with-cypress  
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.0.0'" >> Gemfile  
bundle install  
bundle exec rails new . --force --css=bootstrap -d=postgresql  
bundle update  
  
# Create a default controller  
echo "class HomeController < ApplicationController" > app/controllers/home_controller.rb  
echo "end" >> app/controllers/home_controller.rb  
  
# Create another controller (the one that should not be reached without proper authentication)  
echo "class OtherController < ApplicationController" > app/controllers/other_controller.rb  
echo "end" >> app/controllers/other_controller.rb  
  
# Create routes  
echo "Rails.application.routes.draw do" > config/routes.rb  
echo ' get "home/index"' >> config/routes.rb  
echo ' get "other/index"' >> config/routes.rb  
echo ' root to: "home#index"' >> config/routes.rb  
echo 'end' >> config/routes.rb  
  
# Create a default view  
mkdir app/views/home  
echo '<h1>This is home</h1>' > app/views/home/index.html.erb  
echo '<div><%= link_to "go to other page", other_index_path %></div>' >> app/views/home/index.html.erb  
  
# Create another view (will be also protected by authentication)  
mkdir app/views/other  
echo '<h1>This is another page</h1>' > app/views/other/index.html.erb  
echo '<div><%= link_to "go to home page", root_path %></div>' >> app/views/other/index.html.erb  
  
  
# Create database and schema.rb  
bin/rails db:create  
bin/rails db:migrate  
  
```  
  
Good ! A quick check that everything is running properly, at least locally, by launching :  
  
```shell  
./bin/dev  
```  
  
And open http://localhost:3000  
  
Navigate from one page to another. This is the main feature of our app (wow!). And we don't want to test it manually each time we push a new feature in production, so let's automate its testing properly.  
  
## 5. Install Cypress gem for Rails  
  
First you will need Cypress itself. Run :  
  
```bash  
yarn add --dev cypress  
```  
  
Add this to your Gemfile :  
```ruby  
group :development, :test do  
  gem "cypress-rails"  
end  
```  
  
And run :  
```bash  
bundle install  
# verbose logs...  
# ...  
# ...  
Using rails 7.0.0  
Fetching cypress-rails 0.5.3  
Using turbo-rails 7.1.1  
Installing cypress-rails 0.5.3  
Bundle complete! 18 Gemfile dependencies, 69 gems now installed.  
Use `bundle info [gemname]` to see where a bundled gem is installed.  
```  
  
Great ! Cypress is installed.  
  
Now run :  
```bash  
  bin/rails cypress:init  
```  
  
Ok ! only the cypress.json file has been created  
  
```js  
{  
  "screenshotsFolder": "tmp/cypress_screenshots",  
  "videosFolder": "tmp/cypress_videos",  
  "trashAssetsBeforeRuns": false  
}  
```  
  
Above are the default options of cypress-rails, you can find all available options [here](https://docs.cypress.io/guides/references/configuration#Options)  
  
## 6. Creating files  
  
As you may have notice, you have neither test or directory structure so far. Cypress is smart enough to provide everything needed the first time you run it. Run  
  
```  
bin/rails cypress:open  
```  
  
Wait some seconds, then the IDE of Cypress should appear, like this :  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1641202730/rails/cypress1st.png" loading="lazy" alt="cypress 1st launch">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">cypress 1st launch</figcaption>  
</figure>  
  
  
Cypress suggests you keep or remove existing tests. We suggest you keep them, **they are super-useful as a reference**.  

Once kept, **cut/paste** them elsewhere (in another place of your workspace), so that they won't make too much noise in this tutorial (and in your own project, generally speaking).
  
Here is the created directory structure, at the root of your Rails project :  
  
```  
root  
+-- cypress  
  +--fixtures  
  +--example.json  
  +--integration  
  +--plugins  
  +--index.js  
  +--support  
  +--commands.js  
  +--index.js  
```  
  
the `integration` folder is where you actually write your test : all files ending with `*.spec.js` will run in the Cypress IDE.  
  
The `fixtures` folder is where you define common reference data for your tests, `support` and `plugins` folders are here to allow you to extend Cypress functionalities.  
  
## 7. Our own test  
  
As you may have noticed, the integration folder is not empty. Copy/paste all the content somewhere else - examples inside are really useful, so keep them as reference for later. Then empty completely the content of the `integration` folder.  
  
And write the following test :  
  
```js  
// inside cypress/integration/home.spec.js
describe('Testing Home page', () => {  
  
  beforeEach(() => {  
    cy.visit('/')  
  })  
  
  it('Display a title by default', () => {  
    cy.get('h1').should('contain', 'This is home')  
  })  
  
  it('Allows to navigate from home page, to another', () => {  
    cy.get('a[href*="other/index"]').click()  
    cy.location().should((location) => {  
      expect(location.pathname).to.eq('/other/index')  
    })  
  })  
  
})  
  
```  
  
Then in your terminal run :  
  
```bash  
bin/rails cypress:open  
```  
And click on `home.spec.js` in the IDE  
  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1641204438/rails/cypresstested.png" loading="lazy" alt="cypress demo">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">cypress demo</figcaption>  
</figure>  
  
Great ! Cypress offers a nice IDE that offers nice debugging options.  
  
Back in your terminal, stop Cypress (Ctrl+C) and run  
  
```bash  
bin/rails cypress:run  
```  
  
Amongst other verbose logs, you should see :  
  
```bash  
Testing Home page  
✓ Display a title by default (542ms)  
✓ Allows to navigate from home page, to another (210ms)  
2 passing (776ms)  
```  
  
Good ! Our Cypress suite can run on CI, there is actually no need for an IDE for each scenario.  
  
## 8. A word of caution  
  
It was a gentle introduction to Cypress and Rails. From here, we suggest you to read carefully the README of [https://github.com/testdouble/cypress-rails](https://github.com/testdouble/cypress-rails), particularly the way to initiate the Rails database.  
  
Here at BootrAils we found it extremely useful for 2 cases :  
  
- The "happy path" of your application : you don't want the main functionality of your app to break on each release. The healthiest way to test is when everything is glued together from A to Z.  
- The corner cases where JavaScript and Rails controllers need to work tightly together. The only way to test it properly is with this kind of testing.  
  
However, don't try to reach every use case with Cypress. Context is harder to reach with this kind of testing; moreover, these tests are slower than plain Ruby-based unit tests.  
  
Apart from these warnings, we found that end-to-end testing is finally a breeze of fresh air, thanks to Cypress.  
  
Enjoy !