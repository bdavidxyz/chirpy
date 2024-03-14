---
title: Ruby regex, a friendly guide
redirect_to: https://saaslit.com
author: david
date: 2022-02-03 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby%20regex%20%20a%20friendly%20guide,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20article%20about%20Ruby,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby regex, a friendly guide
---

In this guide, we are going to learn all about Ruby Regex. They are actually called Ruby Regular Expressions, and they should not be confused with [Pattern Matching](https://bootrails.com/blog/ruby-pattern-matching/). If we just think generally, the regular expressions are used to define a search pattern. They are just a small sequence of characters. You use them to match or find a specific piece of string for processing and extracting data by defining search patterns. However there's a small difference with pattern matching. Let's learn everything about them in this guide.

## Ruby Regular Expressions

Hopefully, you have understood the general concept and the use of regular expressions. The very common use of such expressions is validation and parsing. For instance, an email has a specific design and definition and you can use ruby regex to set that design and definition. This specific design helps in validating. Your program would be able to detect whether the email is valid or invalid. 

## Preamble : equal-tilde, the "match operator" of Ruby

`=~` is called the "match operator", and it can be used to test a String against a regular expression.

It matches a regular expression on the left to a String on the right.

When any match is found, index of the first match in String is returned. If the string wasn't found, `nil` will be returned.

## Ruby Regex - Syntax

In ruby, the regular expressions are written inside the two forward slashes `/SearchPattern/`. Whatever your search pattern is, you are required to write them in between two forward slashes. For instance, take a look at the following code.

```ruby
my_string = "There are 10 eggs and 3 pancakes inside this bag"
my_string =~ /eggs/
=> 13
```

In the above, we are simply matching the piece of string `eggs` to see if it's present in the given string or not.  Upon finding it, the program will return the index value of the first letter of the word, in this case, `e`. So, the output will be 13 which is the index value of the first letter of `eggs`. You can also use the method `match()`. Take a look at the code down below. 

```ruby
my_string = "There are 10 eggs and 3 pancakes inside this bag"
my_string.match(/eggs/) ? "Valid" : "Invalid"
=> "Valid"
my_string.match(/eggs42/) ? "Valid" : "Invalid"
=> "Invalid"
```

The `match` method returns `true` or `false`. Let's take a look at some of the advanced search patterns in ruby regex. These regular expressions will help you in executing many useful things, for instance, matching, capturing, updating, replacing the emails, contact numbers, dates, etc. 

## The Character Class

A character class is delimited thanks to the square brackets ( either "["" or "]" ). Using the character class, you can match a list of characters and you can define a range as well. For instance, if you are looking for some particular set of characters inside a string, the syntax would be as follows. 

```ruby
my_string = "hat"
my_string =~ /[abcde]/
=> 1
my_string = "fly"
my_string =~ /[abcde]/
=> nil
```

Now, the first string value contains the letter a, so it will return `1`. But the second string does not contain any given character, so it will return `nil`.

## Ranges

Using the ranges in ruby regex, you can match multiple values at once. You don't need to write them multiple times. You can simply define a range search pattern. 

```ruby
my_string = "I was born in 1998"
my_string =~ /[0-9]/ 
=> 14
```

The above code will search the integer value starting from 0 to 9 and check whether it's present inside a string or not. If found, it will return the index value of the first integer found, in this case, that integer is 1 and its index value is 14. 

If you are someone who will come across ruby regex a lot of times, you should consider memorizing the following shorthand syntax.

- Use **\w** instead of  **[0-9a-zA-Z_]**
- Use **\d** instead of **[0-9]**
- Use **\s** for matching **white space** (newline, regular space, tabs)

## Modifiers

What if we need to match more than one character? In order to match multiple characters at a time, we need to use modifiers.

- Use **+** , if you have 1 or more characters
- Use **\*** , if you have 0 or more characters
- Use **?** , if you have 0 or 1 
- You can also create a range using curly brackets. For instance, use {3,7} to match characters between 3 and 7.

Now if we combine what we have learned so far, we can create even more complex search patterns easily. 

## Exact String Matching

There are many more modifiers that we haven't discussed yet. Some modifiers are used to exactly match the strings. For instance, if we need to find whether the given string has length of exactly four letters, then we'll use the following methods.

```ruby
"Ruby Regex Regular Expressions".match /\w{4}/
```

The above code is correct, but it will still match because the given string has more than four characters. So, how do we get around this? We just simply use the following code.

```ruby
"Ruby Regex Regular Expressions".match /\w{4}$/
```

For the above code, the string won't match. We are using `starting of the line` and `end of line` modifiers. There was quite an easy solution to this by using .size to find the length of the string. But since we are trying to learn more about ruby regex, we think, we have delivered the concept.

## Ruby Regex Options

You can make your regex behave differently by setting the options. Sometimes, we need to make them case insensitive or we are in a situation where we need to ignore white spaces. That's where the ruby regex options come in.

Use **i** to make your search pattern case insensitive.

```ruby
my_string = "There are 10 eggs and 3 pancakes inside this bag"
p my_string.match(/G/i) ? "Valid" : "invalid"
```

 The above code will give `Valid` as an output. 

Use **x** to ignore white spaces. By using **m**, the dot will match a newline.

## Cheat sheet

These lists are inspired from this <a href="https://www.ralfebert.com/snippets/ruby-rails/regex_cheat_sheet/" target="_blank">cheat sheet from ralfebert</a> and this <a href="https://www.cs.umd.edu/class/fall2019/cmsc330/lectures/CMSC330RubyCheatSheet.pdf" target="_blank">excellent PDF notice</a>.

### Modifiers

|  example | explanation |
| --- | --- |
|/.*/m | multiline: . matches newline
|/.*/i | ignore case|
|/.*/x | extended: ignore whitespace in pattern|


### Regular expressions

|  example | explanation |
| --- | --- |
|/Word/ | Exact match|
|/WordThing/ |Concatenation |
|/(Word)(Thing)/ |Concatenation with grouping |
|/(Word\|Thing)/ |Match either |
|/W(ord\|Thing)/ |Match |
|/(Word)*/ |Match 0 or more (in order) |
|/(Word)+/ |Match 1 or more |
|/(Word)?/ | Match 0 or 1|
|/(Word){4}/ |Match exactly 4 |
|/(Word){4,}/ |Match 4 or more |
|/(Word){4,6}/ |Match 4 to 6 |

### String search operation

|  example | explanation |
| --- | --- |
| s.index(target, pos)| Find target, start at pos |
| s.sub(old, new) | Substitute new for 1st old |
| s.gsub(old, new)| Substitute new for old, all  |
| s.split(target) | Split string on target  |
| s =~ /pattern/ | Contains: First position or nil | 
| s !~ /pattern/ | Not contain: true if not found | 


### Extracting substring

|  example | explanation |
| --- | --- |
|s.scan(/pattern/)|Return array of matches|
|s.scan(/(p1)(p2)/)|Return array of arrays|
|str.scan(regexp).each { \|match\| block }|Applies code block to matches, order is preserved|
|str.scan(regexp) { \|match\| block }| Same as above |

### Regexp class and objects

|  example | explanation |
| --- | --- |
|Regexp.new(str)|Create Regexp object with str|
|Regexp.new(regexp)|Create with literal regexp|


`Regexp.new('\w+')` or `Regexp.new(\Ruby\)` are valid examples.

### Character classes

|  example | explanation |
| --- | --- |
|/[abcdef]/|Character class|
|/[a-f]/|Character range|
|/[^0-9]/ , /[^abc]/| Match not in class |
|. (period)|Any character|
|\d|Digit [0-9]|
|\s|Whitespace [\t\r\n\f\s]|
|\w|Alphanumeric [A-Za-z0-9]|
|\D|Non-digit [^0-9]|
|\S|Non-whitespace [^\t\r\n\f\s]|
|\W|Non-word [^A-Za-z0-9]|


### Anchors/Boundaries

|  example | explanation |
| --- | --- |
|\A|Beginning of string (ignores \n)|
|\z|End of string|
|^|Beginning of line (after \n)|
|$|End of line|
|\b|Word boundary|

Anchors and boundaries will not count as characters

### Metacharacters

|  example | explanation |
| --- | --- |
|[ ] { } ^ . $  * ( ) \ + \| ? < >| Must be escaped |

### Special characters

|  example | explanation |
| --- | --- |
|\xaa|Hex character aa|
|\Oaaa|Octal character aaa|
|\\\\|Backslash|
|\n|New line|
|\t|Tab|
|\f|Form feed|
|[\b]|Backspace|
|\r|Carriage return|




## Final Thoughts

Regular expressions are fantastic, but they may be a little challenging at times. You may design your ruby regex in a more dynamic fashion by using online tools. 

It's now your chance to fire up that editor and get coding!