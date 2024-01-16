---
title: How to find an element inside a Ruby array
author: david
date: 2024-02-08 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: How to find an element inside a Ruby array
---

# How to find an element inside a Ruby array

## Use the filter or select method

Like JavaScript, you can choose to `.filter` an Array

Ruby version

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.filter{|e| e.include?('a')}
# ['abc', 'aaa']
```

JS version

```javascript
let ary = ['abc', 'bzz', 'aaa']
ary.filter((e) => e.includes('a'))
// ['abc', 'aaa']
```

Pretty similar right ?


> Side note : When manipulating String, I find the `.include?` (Ruby) and `.includes` (JS) methods to be very confusing. I have to special tip to share here 😬 outside relying on IDE auto-completion.
{: .prompt-tip }


Note that `.select` and `.filter` are the same, it's actually an alias - in Ruby! But not in JS.

So both following method are the same :

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.filter{|e| e.include?('a')}
# [42, 44]
ary.select{|e| e.include?('a')}
# [42, 44]
```

Example above emphasises that both are immutable : the `ary` variable didn't change between consecutives calls.

## Use the include? method

Remember the `.include?` method about String just above ?

Well, it also works with an Array :

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.include?('aaa')
# true
```

Note that the intent is not the same as the paragraph above, so depending on your context, I will list many possibilities.


## How to find the first element inside a Ruby array

Now that we have a way to filter element, how to find the nth element inside a Ruby array ? 

Well, if you're just looking for the first element, `.first` is just here

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.first{|e| e.include?('z')}
'bzz'
```


## How to find the last element inside a Ruby array

Well, nothing fancy here, just use the `.last` method

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.last{|e| e.include?('a')}
'aaa'
```

## How to find the nth element inside a Ruby array

Something I didn't retrieve trivially is the way to find nth element to match a given condition.

First and last was easy (see above) for this scenario.

But what about the nth one ?

```ruby
ary = ['abc', 'bzz', 'aaa']

# Retrive 2nd element with 'a' char
ary.select{|e| e.include?('a')}[1]
# => 'aaa'

# Retrive 3rd element with 'a' char
ary.select{|e| e.include?('a')}[2]
# => nil
```

I let you guess how to write a generic function about this - it's a little bit over-engineering in my humble opinion :

```ruby
def nth(array, condition, position)
  # ...
end
```

# Retrive the index from a given element in Ruby

