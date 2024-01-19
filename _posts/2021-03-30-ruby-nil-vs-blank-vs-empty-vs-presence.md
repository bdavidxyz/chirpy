---
title: Check emptiness in Ruby, nil? vs blank? vs empty? vs presence?
author: david
date: 2021-03-30 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Check%20emptiness%20in%20Ruby%20%20nil%3F%20vs%20blank%3F%20vs%20empty%3F%20vs%20presence%3F,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20article%20about%20Ruby,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Check emptiness in Ruby, nil? vs blank? vs empty? vs presence?
---

## "if" alone may not be enough  
  
`if false` or `if nil` won't execute the corresponding condition, because `false` and `nil` are considered as falsy values.  
  
In other words, if you cast `nil` or `false` as a boolean, it will return `false`. **Every other kind of value is considered truthy in Ruby**. A quick hack (not only specific to Ruby, it also works with JavaScript) is to prepend a double exclamation mark before the variable.  
  
```ruby  
!!nil        # nil => false  
!!false      # boolean false => false  
!!true       # boolean true => true  
!!0          # number zero => true  
!!42         # number other than zero => true  
!!""         # empty string => true  
!!" "        # spaces-only string => true  
!!"sth"      # non-empty string => true  
!![]         # empty array => true  
!![nil]      # array with empty values => true  
!!['a', 'z'] # non-empty array => true  
!!{}         # empty hash => true  
!!{a: nil}   # hash with empty values => true  
!!{a: 42}    # non-empty hash => true  
!!/regex/    # regex => true  
!!Time.now   # any object => true  
```  
  
## .nil? is from Ruby, check if object is actually nil  
  
That's the easy part. In Ruby, you can check if an object is nil, just by calling the nil? on the object... *even if the object is nil*. That's quite logical if you think about it :)  
  
Side note : in Ruby, by convention, every method that ends with a question mark is designed to return a boolean (true or false). In JavaScript, the convention is different : often, this kind of method starts with "is" (isEmpty, isNumeric, etc).  
  
```ruby  
nil.nil?        # nil => true  
false.nil?      # boolean false => false  
true.nil?       # boolean true => false  
0.nil?          # number zero => false  
42.nil?         # number other than zero => false  
"".nil?         # empty string => false  
" ".nil?        # spaces-only string => false  
"sth".nil?      # non-empty string => false  
[].nil?         # empty array => false  
[nil].nil?      # array with empty values => false  
['a', 'z'].nil? # non-empty array => false  
{}.nil?         # empty hash => false  
{a: nil}.nil?   # hash with empty values => false  
{a: 42}.nil?    # non-empty hash => false  
/regex/.nil?    # regex => false  
Time.now.nil?   # any object => false  
```  
  
## .empty? is from Ruby, it checks if size is 0  
  
`.empty?` is a Ruby method, which works **only** for **Hash, Array, or String**. But not for every [Enumerable](https://ruby-doc.org/core-3.0.0/Enumerable.html). It returns true if size is above zero. For others it returns a *NoMethodError*.  
  
```ruby  
nil.empty?        # nil => NoMethodError  
false.empty?      # boolean false => NoMethodError  
true.empty?       # boolean true => NoMethodError  
0.empty?          # number zero => NoMethodError  
42.empty?         # number other than zero => NoMethodError  
"".empty?         # empty string => true  
" ".empty?        # spaces-only string => false  
"sth".empty?      # non-empty string => false  
[].empty?         # empty array => true  
[nil].empty?      # array with empty values => false  
['a', 'z'].empty? # non-empty array => false  
{}.empty?         # empty hash => true  
{a: nil}.empty?   # hash with empty values => false  
{a: 42}.empty?    # non-empty hash => false  
/regex/.empty?    # regex => NoMethodError  
Time.now.empty?   # custom object => NoMethodError  
```  
  
## .blank? is from ActiveSupport  
  
`.blank?` Comes from wonderful [ActiveSupport](https://bootrails.com/blog/rails-active-support). ActiveSupport is a dependency of Rails, so if you are inside the Rails environment, you already have this method, for free.  
  
The `NoMethodError` above could be annoying. So ActiveSupport adds a .blank? method that never fails.  
  
Warning : what is considered as "blank" for Rails is opinionated. String with whitespace is considered "blank", but not the number "0". See the list here :  
  
```  
nil.blank?        # nil => true  
false.blank?      # boolean false => true  
true.blank?       # boolean true => false  
0.blank?          # number zero => false  
42.blank?         # number other than zero => false  
"".blank?         # empty string => true  
" ".blank?        # spaces-only string => true  
"sth".blank?      # non-empty string => false  
[].blank?         # empty array => true  
[nil].blank?      # array with empty values => false  
['a', 'z'].blank? # non-empty array => false  
{}.blank?         # empty hash => true  
{a: nil}.blank?   # hash with empty values => false  
{a: 42}.blank?    # non-empty hash => false  
/regex/.blank?    # regex => false  
Time.now.blank?   # custom object => false  
```  
  
No more errors... but opinionated ways to define what is "blank" or not. So **pay extra attention** :  
  
- `0.blank?` returns false. In my humble opinion, 0 should have been considered as a "blank" value. It would have been more consistent with other languages.  
- `false.blank?` returns true. Could be seen as weird or logical, depending on your habits.  
- `[nil, ''].blank?` returns false. An array of blank values is not considered as blank. This time, I find it logical because the method blank evaluates the array, not what's inside the array.  
- Now the tricky part : `[nil].any?` returns false. But `[''].any?` returns true. It's because the empty string is truthy. If you want to check that `[nil, '']` doesn't contain anything interesting, you can do it this way : `[nil, ''].all?(&:blank?)` returns true.  
  
  
  
## .present? is also from ActiveSupport  
  
.present? is the negation of blank, so no surprise here :  
  
```  
nil.present?        # nil => false  
false.present?      # boolean false => false  
true.present?       # boolean true => true  
0.present?          # number zero => true  
42.present?         # number other than zero => true  
"".present?         # empty string => false  
" ".present?        # spaces-only string => false  
"sth".present?      # non-empty string => false  
[].present?         # empty array => false  
[nil].present?      # array with empty values => true  
['a', 'z'].present? # non-empty array => true  
{}.present?         # empty hash => false  
{a: nil}.present?   # hash with empty values => true  
{a: 42}.present?    # non-empty hash => true  
/regex/.present?    # regex => true  
Time.now.present?   # custom object => true  
```  
  
## Conclusion  
  
As a memo, I put here this decision table, freely inspired by [this article](http://sibevin.github.io/posts/2014-11-11-103928-rails-empty-vs-blank-vs-nil).  
  
  
<table class="table table-striped table-bordered">  
<thead>  
<tr>  
<td>Method</td>  
<td>if ()</td>  
<td>nil?</td>  
<td>empty?</td>  
<td>any?</td>  
<td>blank?</td>  
<td>present?(!blank?)</td>  
</tr>  
</thead>  
<tbody>  
<tr>  
<td>Scope</td>  
<td colspan="4">ruby</td>  
<td colspan="2">rails only</td>  
</tr>  
<tr>  
<td>Object</td>  
<td colspan="2">all</td>  
<td>String, Array, Hash</td>  
<td>Enumerable</td>  
<td colspan="2">all</td>  
</tr>  
<tr>  
<td>nil</td>  
<td>false</td>  
<td>true</td>  
<td>NoMethodError</td>  
<td>NoMethodError</td>  
<td>true</td>  
<td>false</td>  
</tr>  
<tr>  
<td>false</td>  
<td>false</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>NoMethodError</td>  
<td>true</td>  
<td>false</td>  
</tr>  
<tr>  
<td>true</td>  
<td>true</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>NoMethodError</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>0</td>  
<td>true</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>NoMethodError</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>42</td>  
<td>true</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>NoMethodError</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>""</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
<td>NoMethodError</td>  
<td>true</td>  
<td>false</td>  
</tr>  
<tr>  
<td>" "</td>  
<td>true</td>  
<td>false</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>true</td>  
<td>false</td>  
</tr>  
<tr>  
<td>"sth"</td>  
<td>true</td>  
<td>false</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>[]</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
<td>false</td>  
</tr>  
<tr>  
<td>[nil]</td>  
<td>true</td>  
<td>false</td>  
<td>false</td>  
<td>false</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>['a', 'z']</td>  
<td>true</td>  
<td>false</td>  
<td>false</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>{}</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
<td>false</td>  
</tr>  
<tr>  
<td>{ a: nil }</td>  
<td>true</td>  
<td>false</td>  
<td>false</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>{ a: 42 }</td>  
<td>true</td>  
<td>false</td>  
<td>false</td>  
<td>true</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>/regex/</td>  
<td>true</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>NoMethodError</td>  
<td>false</td>  
<td>true</td>  
</tr>  
<tr>  
<td>Time.now</td>  
<td>true</td>  
<td>false</td>  
<td>NoMethodError</td>  
<td>NoMethodError</td>  
<td>false</td>  
<td>true</td>  
</tr>  
</tbody>  
</table>