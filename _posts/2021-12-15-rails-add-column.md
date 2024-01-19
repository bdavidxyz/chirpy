---
title: How to add a column with Rails
author: david
date: 2021-12-15 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20add%20a%20column%20with%20Rails,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to add a column with Rails
---

## Introduction

Let's say you have a table named "books", and an associated model named "Book".

You want to add the column "author".

Tools used in this tutorial : Rails 6.1.3, Ruby 3

Note that this article should work pretty well with any version of Rails or Ruby.

## Short answer

For those who already know Rails, here is the short answer :

inside *db/migrate/20210131201926_add_author_to_books.rb*

```ruby
class AddAuthorToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :author, :string
  end
end
```

And then run `bin/rails db:migrate` at the root of your project.

## Full tutorial

### Install new minimal app

For this tutorial we don't need a full Rails app with bells and whistles, the bare minimum will suffice. From Rails 6.1, the --minimal flag is available when you create a new Rails app.

```bash
$> rails _6.1.3_ new myapp --minimal
$> cd myapp
```
By default, Rails will use an in-memory database named SQLite3.

**Side note** If you want to start with PostgreSQL, you can enter the following command :

```bash
$> rails _6.1.3_ new myapp --minimal --database=postgresql
$> cd myapp
```

### Create the database

```bash
$/myapp> bin/rails db:create
Created database 'myapp_development'
Created database 'myapp_test'
```

### Create a first model

```bash
$/myapp> bin/rails generate model Book title:string body:text
```

Note that "bin/rails" will use the installed rails binary for the current application, instead of the globally available one.

This will create many files :

```
      invoke  active_record
      create    db/migrate/20210331122059_create_books.rb
      create    app/models/book.rb
      invoke    test_unit
      create      test/models/book_test.rb
      create      test/fixtures/books.yml
```

You may not need everything. The interesting thing is the migration file created under `db/migrate/20210131201925_create_books.rb` (The timestamp represent the current time when file was created, of course you will have another than this example)

```ruby
class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
```

Then run the migration

```bash
$/myapp> bin/rails db:migrate
== 20210131201925 CreateBooks: migrating ======================================
-- create_table(:books)
   -> 0.0019s
== 20210131201925 CreateBooks: migrated (0.0020s) =============================
```

### Add a migration file

Create a file named *db/migrate/20210131201926_add_column_to_books.rb*

Check the timestamp, it has to be a greater number than the one of *20210131201925_create_books.rb* previously created. Or the migrations won't be able to be run in the correct order.

```ruby
class AddColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :author, :string
  end
end
```

### Migration file analyzed

We've already seen the timestamp. Now the name of the migration : it actually could be anything. But try to make the intent clear, for yourself or other developers : here I put `add_column_to_books`, a better name could have been `add_author_to_books`. Anyway, make sure that the filename (apart from the timestamp) is the same as the class name.

Now we inherit from ActiveRecord::Migration, for pretty obvious reasons : we want to migrate the data, which is a pretty common behavior, common enough to be hidden inside a standard Rails object,  ActiveRecord::Migration.

The number indicates the 2 first numbers of the Rails version. Here I use Rails 6.1.3, thus the two numbers are [6.1]. It's because features could be available in ActiveRecord::Migration[6.1] that were not available in ActiveRecord::Migration[6.0].

Then the "change" method. You cannot (ahem) change the name, because this method is automagically called when you run `bin/rails db:migrate`.

Finally, `add_column` is pretty clear : first arg is the name of the table, then the name of the column, and then the kind of column.

### Migrate the data

`bin/rails db:migrate` Will actually add the column to your current database.

```bash
$/myapp> bin/rails db:migrate
== 20210131201926 AddColumnToBooks: migrating =================================
-- add_column(:books, :author, :string)
   -> 0.0021s
== 20210131201926 AddColumnToBooks: migrated (0.0022s) ========================
```

### Check the schema.rb file

You can see that the column has been added inside your schema.rb file here :

```
ActiveRecord::Schema.define(version: 20210131201926) do

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "author"
  end

end
```

The added column appear here :  `t.string "author"`

The migration "appears" in another place : the timestamp. Look at `ActiveRecord::Schema.define(version: 20210131201926)` . The timestamp is the one of your migration files.

### Bonus : Inspect created tables - if PostgreSQL is used

If you have used the default SQLite3, please read the next paragraph. If you have chosen PostgreSQL, this is the right paragraph :)

With Rails, you can inspect the actual database by entering the command :

```bash
$/myapp> bin/rails db
psql (13.1)
Type "help" for help.
myapp_development=#
```
Great ! You just entered the PostgreSQL command-line interface (CLI).

```bash
myapp_development=# \dt
List of relations
Schema | Name | Type  | Owner
--------+----------------------+-------+-------
public | ar_internal_metadata | table | shino
public | books                | table | shino
public | schema_migrations    | table | shino
(3 rows)
```

Great ! As you may notice, Rails creates 2 tables by default : ar_internal_metadata, and schema_migrations.

We are only concerned by the "books" table.

Let's display it :

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1639597368/rails/tables.png" loading="lazy" alt="Inside Books Table">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Inside Books Table</figcaption>
</figure>   

### Bonus : Inspect created tables - if SQLite3 is used

This is the same paragraph as above, but the command will apply to a SQLite3 database only (which is the default one with Rails)

```bash
$/myapp> bin/rails db
SQLite version 3.28.0 2019-04-15 14:49:49
Enter ".help" for usage hints.
sqlite> 
```

Then, to display tables
```bash
sqlite> .headers on
sqlite> .mode columns
sqlite> .table
ar_internal_metadata  books schema_migrations 
```

Then, to display the internals of the "Books" table :
```bash
sqlite> PRAGMA table_info('books');
cid         name        type        notnull     dflt_value  pk        
----------  ----------  ----------  ----------  ----------  ----------
0           id          integer     1                       1         
1           title       varchar     0                       0         
2           body        text        0                       0         
3           created_at  datetime(6  1                       0         
4           updated_at  datetime(6  1                       0         
5           author      varchar     0                       0         
```

## The magic way : generate migration

Another possibility is to use the scaffolding, but in this case you have to pay extra attention to the naming of your file :

```bash
$/myapp> bin/rails generate migration AddAuthorToBooks author:string
```
or
```bash
$/myapp> bin/rails generate migration add_author_to_books author:string
```
And the migration file will be filled automagically with all correct values, timestamp included.

In everyday work, I don't use this magic. I simply copy/paste other migrations, paying attention to the name of the file, and that's it.

## Options for add_column

You can see a full list of all available options in this article : [https://api.rubyonrails.org/classes/ActiveRecord/Migration.html](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html)

## Conclusion

Adding a column with Rails is easy, I would say the important thing is to know what's going on, and why.