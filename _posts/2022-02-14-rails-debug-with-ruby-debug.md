---
title: "Debug Rails 7 with ruby/debug"
author: david
date: 2022-02-14 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Debug Rails 7 with ruby/debug"
---

## 1. Prerequisites  
  
Check that you have ruby 3 already installed. Check you also have bundler installed, and npm above version 7  
  
```bash  
$> ruby -v  
ruby 3.0.0p0 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.11
```

Any upper versions should work.  

## 2. Install minimal web application

```bash  
$> mkdir myapp && cd myapp  
$/myapp> echo "source 'https://rubygems.org'" > Gemfile  
$/myapp> echo "gem 'rails', '7.0.0'" >> Gemfile  
$/myapp> bundle install  
$/myapp> bundle exec rails new . --force
$/myapp> bundle update  
$/myapp> bin/rails db:create  
$/myapp> bin/rails db:migrate
```

## 3. Explore the Gemfile

```ruby
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.0"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end
```

See the 3 last lines ? ** the debug gem is available in any Rails application by default **, even for minimalistic apps, which means Rails maintainers consider that this debug gem is something you can't live without.

## 4. Scaffold view, rails, and models

For quick testing (as well as creating admin interfaces), Rails provides scaffolding : full creation of CRUD operation on a resource, 

```bash
$/myapp> bin/rails generate scaffold Computer name:string price:integer
      invoke  active_record
      create    db/migrate/20211222182724_create_computers.rb
      create    app/models/computer.rb
      invoke    test_unit
      create      test/models/computer_test.rb
      create      test/fixtures/computers.yml
      invoke  resource_route
       route    resources :computers
      invoke  scaffold_controller
      create    app/controllers/computers_controller.rb
      invoke    erb
      create      app/views/computers
      create      app/views/computers/index.html.erb
      create      app/views/computers/edit.html.erb
      create      app/views/computers/show.html.erb
      create      app/views/computers/new.html.erb
      create      app/views/computers/_form.html.erb
      create      app/views/computers/_computer.html.erb
      invoke    resource_route
      invoke    test_unit
      create      test/controllers/computers_controller_test.rb
      invoke    helper
      create      app/helpers/computers_helper.rb
      invoke      test_unit
```

We will write about scaffolding later. For now, we just noticed Rails creates all the skeleton for us. Very handy.

Then open config/routes.rb

```rb
# inside config/routes.rb
Rails.application.routes.draw do
  resources :computers
  root to: "computers#index"
end
```

Then run the migration :
```bash  
$> bin/rails db:migrate
```
and launch your local web server
```bash  
$> bin/rails server 
```

finally open your browser at [http://localhost:3000](http://localhost:3000)

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1640198354/rails/computers2.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">localhost</figcaption>  
</figure>  
  
Great ! Everything works. Let's see how to debug this app, before any sudden bug appears.

## 5. Debugging our app

First open *app/controllers/computers_controller.rb*

```ruby
class ComputersController < ApplicationController
  before_action :set_computer, only: %i[ show edit update destroy ]

  # GET /computers
  def index
    @computers = Computer.all
  end
  
  # A lot more code...
end
```

From the comments, you can guess that each time the /computers URL is entered in the browser, the *index* function is called. Fine ! It allows us to easily try the *ruby/debug* gem.

Modify  *app/controllers/computers_controller.rb* as follow

```ruby
class ComputersController < ApplicationController
  before_action :set_computer, only: %i[ show edit update destroy ]

  # GET /computers
  def index
    my_age = 42
    binding.break   
    @computers = Computer.all
    binding.break
  end
  
  # A lot more code...
end
```

So we've added 2 lines `binding.break`

From the name, we can guess Rails server should stop each time it reaches the `binding.break` instruction.

### Reaching a breakpoint

Stop your local web server. Relaunch it with :
```bash  
$> bin/rails server 
```

And refresh your browser at http://localhost:3000

You should see the spinner that indicates your page cannot load right now :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1640334634/rails/spinnerloading_24.png" loading="lazy" alt="spinner">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">spinner</figcaption>  
</figure>  

Probably the breakpoint was actually reached, as planned !

Open your terminal :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1640334936/rails/blockedwow.png" loading="lazy" alt="beautiful colors in terminal">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">beautiful colors in terminal</figcaption>  
</figure>  

The program has stopped where you asked it to stop : on the `binding.break` instruction.

Lesson 1 :

> ruby/debug allow us to debug a Ruby-on-Rails program right into the terminal, with all features you would usually find in an IDE : next step, evaluate, continue, etc

Lesson 2 :

> ruby/debug comes with beautiful colors, which helps a lot.

### Evaluate a variable

Inside your terminal, the cursor is already positioned inside the ruby debugger. 

Type
```bash  
(rdbg) my_age # ruby
42
(rdbg) @computers
nil
(rdbg)
```

`my_age` already exists, and the debugger shows us its value. Neat ! @computers is not yet set once we reach the first breakpoint, so its value is `nil` (for now).

### Set a variable

```bash  
(rdbg) eval my_age=43    # command
(rdbg) my_age    # ruby
43
(rdbg)
```

Very useful if you want to reach a particular state inside your controller or service object. Note also the comment at the end of each line.

Lesson 3 :

> ruby/debug makes it possible to read, but also write any variable on-the-fly, allowing your Rails app to reach any desired state.

Lesson 4 :

> ruby/debug has a nice developer UX, by trying to comment existing commands (if no comment appears, you are trying to type a command that doesn't exist...)

### Jump to next breakpoint

```bash  
(rdbg) c    # continue command
[4, 13] in ~/workspace/myapp/app/controllers/computers_controller.rb
     4|   # GET /computers
     5|   def index
     6|     my_age = 42
     7|     binding.break   
     8|     @computers = Computer.all
=>   9|     binding.break   
    10|   end
```

Now, no surprise, if you evaluate `@computers`, it exists :

```bash  
(rdbg) @computers # ruby
[]
(rdbg) 3 + 4 # ruby
7
```

Note that you can type in any Ruby expression, not just existing variables.

### Escape the debugger

Type "c" and "enter" until you escape from all breakpoints :

```bash  
(rdbg) c    # continue command
  Rendering layout layouts/application.html.erb
  Rendering computers/index.html.erb within layouts/application
  Rendered computers/index.html.erb within layouts/application (Duration: 0.7ms | Allocations: 327)
  Rendered layout layouts/application.html.erb (Duration: 4.4ms | Allocations: 1317)
Completed 200 OK in 1581101ms (Views: 9.0ms | ActiveRecord: 9.0ms | Allocations: 139408)
```

And go back to the browser, at http://locahost:3000. The spinner has disappeared. If you reload the page, the spinner is here again, and you can enjoy a new debugging session in your terminal.

## All available options

Inside the debugger, type "h"

```bash
(rdbg) h    # help command
### Control flow

* `s[tep]`
  * Step in. Resume the program until next breakable point.
* `s[tep] <n>`
  * Step in, resume the program at `<n>`th breakable point.
* `n[ext]`
  * Step over. Resume the program until next line.
* `n[ext] <n>`
  * Step over, same as `step <n>`.
* `fin[ish]`
  * Finish this frame. Resume the program until the current frame is finished.
* `fin[ish] <n>`
  * Finish `<n>`th frames.
* `c[ontinue]`
  * Resume the program.
* `q[uit]` or `Ctrl-D`
  * Finish debugger (with the debuggee process on non-remote debugging).
* `q[uit]!`
  * Same as q[uit] but without the confirmation prompt.
* `kill`
  * Stop the debuggee process with `Kernel#exit!`.
* `kill!`
  * Same as kill but without the confirmation prompt.
* `sigint`
  * Execute SIGINT handler registered by the debuggee.
  * Note that this command should be used just after stop by `SIGINT`.

### Breakpoint

* `b[reak]`
  * Show all breakpoints.
* `b[reak] <line>`
  * Set breakpoint on `<line>` at the current frame's file.
* `b[reak] <file>:<line>` or `<file> <line>`
  * Set breakpoint on `<file>:<line>`.
* `b[reak] <class>#<name>`
   * Set breakpoint on the method `<class>#<name>`.
* `b[reak] <expr>.<name>`
   * Set breakpoint on the method `<expr>.<name>`.
* `b[reak] ... if: <expr>`
  * break if `<expr>` is true at specified location.
* `b[reak] ... pre: <command>`
  * break and run `<command>` before stopping.
* `b[reak] ... do: <command>`
  * break and run `<command>`, and continue.
* `b[reak] ... path: <path_regexp>`
  * break if the triggering event's path matches <path_regexp>.
* `b[reak] if: <expr>`
  * break if: `<expr>` is true at any lines.
  * Note that this feature is super slow.
* `catch <Error>`
  * Set breakpoint on raising `<Error>`.
* `catch ... if: <expr>`
  * stops only if `<expr>` is true as well.
* `catch ... pre: <command>`
  * runs `<command>` before stopping.
* `catch ... do: <command>`
  * stops and run `<command>`, and continue.
* `catch ... path: <path_regexp>`
  * stops if the exception is raised from a path that matches <path_regexp>.
* `watch @ivar`
  * Stop the execution when the result of current scope's `@ivar` is changed.
  * Note that this feature is super slow.
* `watch ... if: <expr>`
  * stops only if `<expr>` is true as well.
* `watch ... pre: <command>`
  * runs `<command>` before stopping.
* `watch ... do: <command>`
  * stops and run `<command>`, and continue.
* `watch ... path: <path_regexp>`
  * stops if the triggering event's path matches <path_regexp>.
* `del[ete]`
  * delete all breakpoints.
* `del[ete] <bpnum>`
  * delete specified breakpoint.

### Information

* `bt` or `backtrace`
  * Show backtrace (frame) information.
* `bt <num>` or `backtrace <num>`
  * Only shows first `<num>` frames.
* `bt /regexp/` or `backtrace /regexp/`
  * Only shows frames with method name or location info that matches `/regexp/`.
* `bt <num> /regexp/` or `backtrace <num> /regexp/`
  * Only shows first `<num>` frames with method name or location info that matches `/regexp/`.
* `l[ist]`
  * Show current frame's source code.
  * Next `list` command shows the successor lines.
* `l[ist] -`
  * Show predecessor lines as opposed to the `list` command.
* `l[ist] <start>` or `l[ist] <start>-<end>`
  * Show current frame's source code from the line <start> to <end> if given.
* `edit`
  * Open the current file on the editor (use `EDITOR` environment variable).
  * Note that edited file will not be reloaded.
* `edit <file>`
  * Open <file> on the editor.
* `i[nfo]`
   * Show information about current frame (local/instance variables and defined constants).
* `i[nfo] l[ocal[s]]`
  * Show information about the current frame (local variables)
  * It includes `self` as `%self` and a return value as `%return`.
* `i[nfo] i[var[s]]` or `i[nfo] instance`
  * Show information about instance variables about `self`.
* `i[nfo] c[onst[s]]` or `i[nfo] constant[s]`
  * Show information about accessible constants except toplevel constants.
* `i[nfo] g[lobal[s]]`
  * Show information about global variables
* `i[nfo] ... </pattern/>`
  * Filter the output with `</pattern/>`.
* `i[nfo] th[read[s]]`
  * Show all threads (same as `th[read]`).
* `o[utline]` or `ls`
  * Show you available methods, constants, local variables, and instance variables in the current scope.
* `o[utline] <expr>` or `ls <expr>`
  * Show you available methods and instance variables of the given object.
  * If the object is a class/module, it also lists its constants.
* `display`
  * Show display setting.
* `display <expr>`
  * Show the result of `<expr>` at every suspended timing.
* `undisplay`
  * Remove all display settings.
* `undisplay <displaynum>`
  * Remove a specified display setting.

### Frame control

* `f[rame]`
  * Show the current frame.
* `f[rame] <framenum>`
  * Specify a current frame. Evaluation are run on specified frame.
* `up`
  * Specify the upper frame.
* `down`
  * Specify the lower frame.

### Evaluate

* `p <expr>`
  * Evaluate like `p <expr>` on the current frame.
* `pp <expr>`
  * Evaluate like `pp <expr>` on the current frame.
* `eval <expr>`
  * Evaluate `<expr>` on the current frame.
* `irb`
  * Invoke `irb` on the current frame.

### Trace

* `trace`
  * Show available tracers list.
* `trace line`
  * Add a line tracer. It indicates line events.
* `trace call`
  * Add a call tracer. It indicate call/return events.
* `trace exception`
  * Add an exception tracer. It indicates raising exceptions.
* `trace object <expr>`
  * Add an object tracer. It indicates that an object by `<expr>` is passed as a parameter or a receiver on method call.
* `trace ... </pattern/>`
  * Indicates only matched events to `</pattern/>` (RegExp).
* `trace ... into: <file>`
  * Save trace information into: `<file>`.
* `trace off <num>`
  * Disable tracer specified by `<num>` (use `trace` command to check the numbers).
* `trace off [line|call|pass]`
  * Disable all tracers. If `<type>` is provided, disable specified type tracers.
* `record`
  * Show recording status.
* `record [on|off]`
  * Start/Stop recording.
* `step back`
  * Start replay. Step back with the last execution log.
  * `s[tep]` does stepping forward with the last log.
* `step reset`
  * Stop replay .

### Thread control

* `th[read]`
  * Show all threads.
* `th[read] <thnum>`
  * Switch thread specified by `<thnum>`.

### Configuration

* `config`
  * Show all configuration with description.
* `config <name>`
  * Show current configuration of <name>.
* `config set <name> <val>` or `config <name> = <val>`
  * Set <name> to <val>.
* `config append <name> <val>` or `config <name> << <val>`
  * Append `<val>` to `<name>` if it is an array.
* `config unset <name>`
  * Set <name> to default.
* `source <file>`
  * Evaluate lines in `<file>` as debug commands.
* `open`
  * open debuggee port on UNIX domain socket and wait for attaching.
  * Note that `open` command is EXPERIMENTAL.
* `open [<host>:]<port>`
  * open debuggee port on TCP/IP with given `[<host>:]<port>` and wait for attaching.
* `open vscode`
  * open debuggee port for VSCode and launch VSCode if available.
* `open chrome`
  * open debuggee port for Chrome and wait for attaching.

### Help

* `h[elp]`
  * Show help for all commands.
* `h[elp] <command>`
  * Show help for the given command.
(rdbg) 
```

## Alternatives to ruby/debug

You can try the byebug gem, or read [this famous article](https://tenderlovemaking.com/2016/02/05/i-am-a-puts-debuggerer.html) about debugging directly with some "print" statements. It's also very efficient !