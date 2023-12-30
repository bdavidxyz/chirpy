---
title: "Ruby strftime, short and long story"
author: david
date: 2022-01-13 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby strftime, short and long story"
---

## strftime for the impatients

Sometimes examples worth a thousand words, so here are some that could help you right away (example inspired from APIDoks) :

```ruby
d = DateTime.new(2021,11,19,8,37,48,"-06:00")
# => Fri, 19 Nov 2021 08:37:48 -0600
d.strftime("Printed on %m/%d/%Y")   
# => "Printed on 11/19/2021"
d.strftime("at %I:%M%p")
# => "at 08:37AM"
```

And a lot more of raw examples (explanations in paragraphs below)

```ruby
%Y%m%d           => 20211119                  
%F               => 2021-11-19                
%Y-%m            => 2021-11                   
%Y               => 2021                      
%C               => 20                        
%Y%j             => 2021323                   
%Y-%j            => 2021-323                  
%GW%V%u          => 2021W471                  
%G-W%V-%u        => 2021-W47-1                
%GW%V            => 2021W47                   
%G-W%V           => 2021-W47                  
%H%M%S           => 083748                    
%T               => 08:37:48                  
%H%M             => 0837                      
%H:%M            => 08:37                     
%H               => 08                        
%H%M%S,%L        => 083748,000                
%T,%L            => 08:37:48,000              
%H%M%S.%L        => 083748.000                
%T.%L            => 08:37:48.000              
%H%M%S%z         => 083748-0600               
%T%:z            => 08:37:48-06:00            
%Y%m%dT%H%M%S%z  => 20211119T083748-0600      
%FT%T%:z         => 2021-11-19T08:37:48-06:00 
%Y%jT%H%M%S%z    => 2021323T083748-0600       
%Y-%jT%T%:z      => 2021-323T08:37:48-06:00   
%GW%V%uT%H%M%S%z => 2021W471T083748-0600      
%G-W%V-%uT%T%:z  => 2021-W47-1T08:37:48-06:00 
%Y%m%dT%H%M      => 20211119T0837             
%FT%R            => 2021-11-19T08:37          
%Y%jT%H%MZ       => 2021323T0837Z             
%Y-%jT%RZ        => 2021-323T08:37Z           
%GW%V%uT%H%M%z   => 2021W471T0837-0600        
%G-W%V-%uT%R%:z  => 2021-W47-1T08:37-06:00    
```


## Long story about strftime

Programmers need to constantly convert between different date and time formats. People in different parts of the world prefer dates to be displayed in different ways as is also true for many different systems that require dates to be in a specific format to be accepted. Catering for different date formats can be quite a pain. But it will remain a pain no longer because after this article you will become a wizard with the powers to easily format date/time in Ruby.
  
Ruby formats `Time` objects in a specific way by default. But you may want something else that can adapt to your case. Great! Ruby has a method specifically for this job. The 'strftime' (string format time) method can get you any format you will ever possibly need. It is a highly flexible method with a lot of options for you to experiment with. You can get the time without the date, or a nicely formatted date with the year, day & name of the current month.

It works by passing a string with format specifiers. These specifiers, more formally called directives, will be replaced by a value as they instruct the method to customize the resulting human readable date. If you have ever used the printf method the idea is very similar to that. Here are a few examples:

 
```ruby
time = Time.new  
time.strftime("%d/%m/%Y") # "05/12/2015"
time.strftime("%I:%M %p") # "11:04 PM"
time.strftime("%d of %B, %Y") # "21 of December, 2015"
```

Before diving into the depths of the `strftime` method we need you to take this quick refresher on the `Time` class in Ruby so that you are fully prepared to gain the most out of this lesson.


### The beginning of `Time`:

Although the strftime method is relevant to all time-related classes including Date, Time, and DateTime, we can get by with only understanding the Time class. The Time class in Ruby represents dates and times stored as the number of seconds that have elapsed since January 1, 1970 00:00 UTC. This time is known as the 'Unix epoch' and can be considered the starting point of time for computers. It has been used to grab the current time, date, and year since that time and until 2038. A time instance in Ruby holds both date and time. The date component consists of the day, month and year while the time component consists of the hour, minutes, and seconds.  

In Ruby, you can get the current day and time using `Time.new` or `Time.now` and assign it to a variable. You can then get the year, month, day, hour, minute, second, etc in the following manner:


```ruby

t = Time.now()
puts t.year()
# => 2022

puts t.month()
# => 1

puts t.day()
# => 7

puts t.hour()
# => 22

puts t.min()
# => 0

puts t.sec()
# => 46
```

So what does a `Time` instance in Ruby look like on its own.

```ruby
t = Time.now()
puts t
# => 2022-01-08 13:35:53 +0000
```

As you can see this format might be less than desirable in some circumstances. Before overloading you with all the possible combinations of directives we can provide the `strftime` method, let us first go through the real-world scenario where we want to send the front-end of our application a nicely formatted date that represents the joining date for a customer. Let's learn how to do that in the next section where we go through the thought process of applying different directives to strftime to reach our desired result.

### strftime : application and thought process

As stated earlier we want to display the data represented by the time instance such as `2022-01-08 13:35:53 +0000`, into `Saturday, 08 Jan 2022`. The latter seems to be a much more common format that you would find on a website. So how do we get it? Firstly we need the full name of the day of the week i.e 'Sunday'. By checking the 'Weekday' section of the cheat sheet shown later in this lesson we identify that we need to use the specifier `%A`..

```ruby
t = Time.new(2022,1,8,13,35,53)
puts t.strftime("%A")
# => Saturday
```

Pretty cool right? Okay, maybe it doesn't look *that* cool just yet. Let's apply the rest of the directives. Next, I want to get, `08`, the day of month padded with a zero if it's a single digit. I simply tack on another directive, `%d`, that allows me to do just that. Similarly, for `Jan`, the abbreviated month we have `%b` and finally for `2022`, the full numerical year, we have `%Y`. Altogether it becomes:

```ruby
t = Time.new(2022,1,8,13,35,53)
puts t.strftime("%A %d %b %Y")
# => Saturday 08 Jan 2022
```

The date is now properly formatted but the observant reader might have noticed that there is still something missing. Yes, the 'comma' is missing. Points for you if you got it. There isn't a directive or specifier for a comma or any string for that matter, but not to worry. Any string you provide that is not listed in the docs as a directive, will simply be output to the resulting string. Applying this information to the example above we simply add a comma after our first directive like so:


```ruby
puts t.strftime("%A, %d %b %Y")
# => Saturday, 08 Jan 2022
```

Perfect !

You are now ready to be bombarded with as many directives as your heart desires.
  

## Deep dive

This section first shows the basics of the `strftime` method, then contains a basic cheat sheet that you will need to get familiar with over time, and finally drives the concept home with some cool examples.


The `strftime` method requires a directive with the following structure and rules:


Structure - `%<flags><width><modifier><conversion>`

Rules:

1. A directive starts with a percent (%) character.

2. A flag and the conversion specifiers tell the method how to display the time and date.

3. The minimum field width specifies the minimum width. You can ignore this.

4. The modifiers are "E" and "O". Can also be ignored.

5. Regular text that isn't listed in the directives will pass through as it is in the output.

  

## strftime cheat sheet

### Flags

| Syntax | Description |
|--|--|
| \- | no padding on a numerical output |
| _ | pad with spaces |
| 0 | pad with zeros |
| ^ | Upcase the result string |
| : | Use colons for %z |
  
### Date (Year, Month, Day)

| Syntax | Description |
|--|--|
| %Y | Year with century |
| %y | year % 100 (00..99) |
| %m | Month of the year, zero-padded (01..12) |
| %B | The full month name ('January') |
| %b | The abbreviated month name ('Jan') |
| %d | Day of the month, zero-padded (01..31) |
| %j | Day of the year (001..366) |

### Time (Hour, Minute, Second):

| Syntax | Description |
|--|--|
| %H | Hour of the day, 24-hour clock, zero-padded (00..23) |
| %k | Hour of the day, 24-hour clock, blank-padded ( 0..23) |
| %I | Hour of the day, 12-hour clock, zero-padded (01..12) |
| %l | Hour of the day, 12-hour clock, blank-padded ( 1..12) |
| %P | Meridian indicator, lowercase ('am' or 'pm') |
| %p | Meridian indicator, uppercase ('AM' or 'PM') |
| %M | Minute of the hour (00..59) |
| %S | Second of the minute (00..60) |
| %z | Time zone as an hour and minute offset from UTC (e.g. +0900) |  

### Weekday:

| Syntax | Description |
|--|--|
| %A |The full weekday name (e.g. Sunday)|
| %a |The abbreviated weekday name (e.g. Sun)|
| %u |Day of the week starting Monday (1..7)|

### Useful Combinations:

  
| Syntax | Description |
|--|--|
| %c | Date and time (%a %b %e %T %Y) |
| %D | Date (%m/%d/%y) |
| %F | The ISO 8601 date format (%Y-%m-%d) |
| %r | 12-hour time (%I:%M:%S %p) |
| %R | 24-hour time (%H:%M) |
  
For a more comprehensive list of options please visit the strftime method in [Ruby Docs](https://devdocs.io/ruby~3/time#method-i-strftime).

## Last words : random examples

Initialize time:

```ruby
t = Time.new(2022,1,8,13,35,53)
```

Time for your appointment:

```ruby
puts t.strftime("%B, %Y at %-I:%M %p")
# => January, 2022 at 12:13 AM
```

Alarm Clock:

```ruby
puts t.strftime("%r")
# => 12:13:29 AM
```

Windows OS date:

```ruby
puts t.strftime("%d/%m/%Y")
# => 09/01/2022
```

Fun Fact Date:

```ruby
puts t.strftime("%-d %b is on a %A and is day number %j of the year %Y")
# => 8 Jan is on a Saturday and is day number 008 of the year 2022
```
  
That's pretty much it. Now go out there and make some unique looking date formats!