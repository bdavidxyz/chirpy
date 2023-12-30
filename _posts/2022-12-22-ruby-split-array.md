---
title: "Ruby Split Array"
author: david
date: 2022-12-22 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby Split Array"
---

## Split method for a Ruby array

Let's start with a simple example :

```ruby
[1, 42, 99, 200].split(42)
# => returns [[1], [99, 200]]
```

Yikes! It returns a 2D-Array. After all, it's logical because you have asked to separate the initial Array into multiple parts. But when this line appears within thousands lines of code, it's easy to forget about it.

Side note : the same operation is **not possible in native JavaScript** so far.

## More examples

Given the answer above, here is how you apply the `.split` method for array in various situations :

```ruby
[1, 42, 99, 200].split()
# => returns [[1], [42], [99], [200]]
```

Any arguments that doesn't match any element in the initial array will return the same result :

```ruby
[1, 42, 99, 200].split("")
# => returns [[1, 42, 99, 200]]

[1, 42, 99, 200].split(101)
# => returns [[1, 42, 99, 200]]

[1, 42, 99, 200].split("foo")
# => returns [[1, 42, 99, 200]]
```

We can also pass a block :

```ruby
# This will return the same result as [1, 42, 99, 200].split(42)
[1, 42, 99, 200].split{|x| x % 42 === 0}
# => returns [[1], [99, 200]]

[1, 42, 99, 200].split{|x| x % 2 === 0}
# => returns [[1], [99], []]
```


## Ruby Array .split vs Ruby String .split

### String

For a String, the signature is as follow:

 * `.split(pattern, limit)`
 * limit is a number, to define how much parts can be splitted.
 * *pattern* is a String or a [RegEx](/blog/ruby-regex-friendly-guide/)

Here is a example with a limit :

```ruby
# Ruby
myString = "hello_world_dude"
myString.split("_", 2)
// => returns ["hello", "world_dude"]
```

### Array

 * `.split(pattern)`
 * *pattern* is a value or a [Block](/blog/ruby-block-procs-and-lambda/)

```ruby
# Ruby
myArray = [1, "e", 22]
myArray.split("e")
// => returns [[1], [22]]
myArray.split{|x| x === "e"}
// => returns [[1], [22]]
```

## Split a 2D Array

Given the paragraph above, the following example should not surprise you:

```ruby
# Ruby
arr = [[1,2,3], ["a","b"], [1,12,4]]
arr.split(2)
# => [[[1, 2, 3], ["a", "b"], [1, 12, 4]]]
arr.split(["a", "b"])
# => [[[1, 2, 3]], [[1, 12, 4]]]
```

## Split an Array into chunks

Loot at the 
<a href="https://ruby-doc.org/core-3.1.0/Enumerable.html#method-i-each_slice" target="_blank">each_slice</a> method of the Enumerable module:

```ruby
[1, 2, 3, 4, 5, 6, 7].each_slice(3)
# => #<Enumerator: ...>
[1, 2, 3, 4, 5, 6, 7].each_slice(3).to_a
# => [[1, 2, 3], [4, 5, 6], [7]]
```

[Enumerators](/blog/ruby-enumerator-what-why-how/) are a feature of Ruby.

## Conclusion

Split for an Array is not much different than the usual "split" for a String. Just remind that the result is always an Array that is one dimension _bigger_ than the initial Array.