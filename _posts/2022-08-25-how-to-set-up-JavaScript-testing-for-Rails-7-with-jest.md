---
title: How to set up JavaScript testing for Rails 7 with Jest
author: david
date: 2022-08-25 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20set%20up%20JavaScript%20testing%20for%20Rails%207%20with%20Jest,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to set up JavaScript testing for Rails 7 with Jest
---

## Prerequisites for Ruby, Rails, and JS environment
  
Here are the tools I used for this tutorial. 
  
```shell  
$> ruby --version  
=> 3.1.2  
$> rails --version  
=> 7.0.3.1  
$> node --version  
=> 18.6.0  
$> yarn --version  
=> 1.22.19  
```  

## Create new Rails app - no JavaScript yet
  
```shell  
$> rails new myapp && cd myapp  
```  
Now wait for a minute... okay ! you have now a fresh new default Rails app.  


## Add the bare minimum files
  
Create a controller as follow in `app/controllers/welcome_controller.rb `
  
```ruby  
# inside app/controllers/welcome_controller.rb  
class WelcomeController < ApplicationController  
end
```  
  
Configure a default route in config/routes.rb as follow  
  
```ruby  
# inside config/routes.rb  
Rails.application.routes.draw do  
  get "welcome/index"  
  root to: "welcome#index"  
end  
```  

Add a view inside `app/views/welcome/index.html.erb`

```html
<!-- inside app/views/welcome/index.html.erb -->
<h1>Hello !<h1>
```
## Add and use an ES6 module

Create an ES6 module by creating a new file under `app/javascript/magicAdd.js`

```js
// inside app/javascript/magicAdd.js
const  magicAdd = (a, b) => {
  return a + b;
}
export default  magicAdd;
```

And reference this file from the main pack :

```js  
// inside app/javascript/packs/application.js

// You can left pre-existing JavaScript, that's ok :)

import magicAdd from './magicAdd.js'

let a = magicAdd(2, 4);

console.log(`From mainjs, magicAdd result is ${a}`)
```

Stop your local web server, and run 

```shell  
$/myapp> bin/rails server
```  

If no error is shown, you can run the local web server :

```shell  
$/myapp> bin/rails s
```

Now open your browser and check the browser's console to see if everything works properly.

## Create a test for the JavaScript module

 Create a new file inside `test/javascript/magicAdd.spec.js`

```js
// inside test/javascript/magicAdd.spec.js
import magicAdd from 'magicAdd.js'

describe('magicAdd', () => {

  test('add two numbers', () => {
    // given
    let result = 0;
    // when
    result = magicAdd(1, 3)
    // then
    expect(result).toEqual(4);
  });
  
});
```

## Add JavaScript dependencies to run the unit test

We need now :

 - `jest`, which is our testing framework,
 - `@babel/preset-env` and `babel-jest` because of the use of ES6,
 -  `istanbul-reports` to have a nice code coverage report.

So let's run 

```shell  
$/myapp> yarn add --dev @babel/preset-env babel-jest jest istanbul-reports 
```

## Configure Jest

Open package.json, it should look like this :

```js
{
  "devDependencies": {
    "@babel/preset-env": "^7.18.10",
    "babel-jest": "^28.1.3",
    "istanbul-reports": "^3.1.5",
    "jest": "^28.1.3"
  }
}
```

Add the following property to package.json, so that Jest will know which directories and file to watch, and which  one to ignore :

```js
{
   // all properties as above remain the same...
   "devDependencies": {
    "@babel/preset-env": "^7.18.10",
    "babel-jest": "^28.1.3",
    "istanbul-reports": "^3.1.5",
    "jest": "^28.1.3"
  },
   // add the following property to package.json
  "jest": {
    "testPathIgnorePatterns": [
      "node_modules/",
      "config/webpack/test.js",
      "vendor/bundle/ruby"
    ],
    "moduleDirectories": [
      "node_modules",
      "app/javascript"
    ],
    "collectCoverage": true,
    "coverageReporters": [
      "text",
      "html"
    ],
    "coverageDirectory": "coveragejs"
  }
```

## Configure babel with your Rails app

Add the following code inside `babel.config.js`, at the root of your Rails project.

```javascript
module.exports = { 
  presets: ["@babel/preset-env"],
};
```

## Launch tests

That's the big moment.

Run

```shell  
$/myapp> yarn jest

**yarn run v1.22.19**

**PASS** **test/javascript/****magicAdd.spec.js**

**magicAdd**

**✓**  **add two numbers (2 ms)**

  

**-------------|---------|----------|---------|---------|-------------------**

**File | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s**

**-------------|---------|----------|---------|---------|-------------------**

**All files** **|** **100** **|** **100** **|** **100** **|** **100** **|**

**magicAdd.js** **|** **100** **|** **100** **|** **100** **|** **100** **|**

**-------------|---------|----------|---------|---------|-------------------**

**Test Suites:** **1 passed****, 1 total**

**Tests:** **1 passed****, 1 total**

**Snapshots:** **0 total**

**Time:** **0.656 s**

**Ran all test suites.**

**✨  Done in 1.54s.**
```

And open coveragejs/index.html in your browser to get coverage.

## Summary

Nothing complicated, but as often with npm projects, you have to take of dependencies and insert libs in the right order. Start from a simple example like this one to understand how things work, we hope it helped!