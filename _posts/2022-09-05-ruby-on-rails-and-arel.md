---
title: "Ruby-on-Rails and Arel"
author: david
date: 2022-09-05 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby-on-Rails and Arel"
---

## Rails: Applications, databases and the Active Record

Ruby on Rails is a powerful framework to create applications based on the [MVC Architecture](https://www.bootrails.com/blog/ruby-on-rails-mvc/). One of its most valuable assets is that you can build solid and reliable relational databases. This is thanks to the **Active Record**, which stores the database and enables interaction: getting, updating, creating and deleting data.

The data or the information behind an application is what makes it interesting to users; an application with no data is of no value. In this sense, the characteristics of a relational database are:

- The database is built on a schema of relations between tables. Data relations can be <a href="https://medium.com/@emekadc/how-to-implement-one-to-one-one-to-many-and-many-to-many-relationships-when-designing-a-database-9da2de684710" target="_blank" >one-to-one, one-to-many or many-to-many</a>.
- The information can be organized into layers to facilitate querying and filtering.
- The user can access data and modify it according to permit.

## Database querying

When having to execute queries on databases it is common to use **SQL language**. While Ruby allows us to embed SQL in our code, we can interact with the Active Record writing queries like the one below:

```ruby
Book.where(author: "Ken Follett")
```

This is definitely more readable and faster to write than SQL. And the best part is, that we can easily convert it to SQL by adding the method `to_sql`:

```ruby
Book.where(author: "Ken Follett").to_sql
# SELECT "book".* FROM "book"
# WHERE "book"."author" = 'Ken Follett'
```

## What is Arel?

Rails 3 introduced a new library called **Arel** to provide a language to write SQL queries in a much clearer and readable form. Arel supports both simple and complex queries. Nowadays, Arel is bundled into the [Active Record](https://rubygems.org/gems/activerecord) gem, and maintained in the [rails/rails](https://github.com/rails/rails) repository.

## Arel benefits

- Arel saves us from using interpolation.
- It benefits from previously scoped behavior in the different object classes, so that there is no need of rewriting in each SQL query.
- When writing more complicated queries, Arel is easy to read and more reliable. If we start to create table `joins` and other connections in SQL, it becomes more probable that the query breaks at some point.

## Arel syntax and basic query structure

To interact with the Arel library we use the method `arel_table`. This means, we need to create an `Arel::Table` object for each data table that we want to work with:

```ruby
books = Book.arel_table
```

A table has a set of columns and Arel converts each column into a node `Arel::Node`. A **node** supports the execution of different **methods** that are defined in the library in order to build fast and readable queries. We will start now analyzing the most used methods.

Having the "Books" `Arel::Table`, a simple Arel query would look like this:

```ruby
books.[:author].eq("Ken Follett").and(books[:price].lt(20))
```

This query would be used to get books written by _Ken Follett_ and which price is less than 20$. Notice that we are querying the table "Books" by executing methods on the nodes related to the "author" and "price" columns. The basic syntax methods (incl. `Arel::Predications`) in Arel are:

- Equal (**eq**) / Not equal (**not_eq**)
- Less than (**lt**) / Greater than (**gt**)
- Less or equal than (**lteq**) / Greater or equal than (**gteq**)
- And (**and**) / Or (**or**)

Note that to see all Arel predications you can run: `Arel::Predications.instance_methods`

## Arel: Main operations and methods

### Where queries

**Where queries** are the most common, we could say that more than 75% of the queries are built using `where`. This clause is used basically to filter our data and share the information with users.

To connect the restriction query with Active Record we just need to call it on the related model. Following the below example, we execute the query on the Book-Model:

```ruby
Book.where(books[:id].in([1,2,3]))
```

### Projection queries

**Projection queries** in Arel are the equivalent to select queries. We use the keyword `project` to specify the nodes we want to select or return.

Note that the procedure to connect these queries with the Active Record is a little bit more complex:

```ruby
# The query to get the title of books written by Ken Follett:
books.where(books[:author].eq("Ken Follett").project(:title))
# Active Record connection:
ActiveRecord::Base.connection.exec_query books.where(books[:author].eq("Ken Follett").project(:title))
```

### Joins

With Arel we can execute both, **inner joins** and **outer joins**. As per the below example, you will see that Arel is much more simple and more readable than SQL when it comes to joining sets of data:

```ruby
comments = Comment.arel_table
books.join(comments)
```

Now, being more specific using inner join:

```ruby
books.join(comments, Arel::Nodes::InnerJoin).on(books[:id].eq(comments[:book_id]))
```

### Additional methods to scope queries

1. **Aggregates**: Used to perform operations on values, such as `sum`, `count`, `average`, `min` and `max`.
```ruby
books.project(books[:price].average)
```

2. **Order**: Used to organize information on an ascending or descending basis.
```ruby
books.order(books[:price].desc)
```

3. **Limitators**: Used to limit (`take`) and offset (`skip`) query results.
```ruby
books.take(10)
```

## Conclusion

As we have seen in this article, there are several ways to interact with the information in a database with Ruby. You can stick to standard SQL language, access the Active Record directly or use the Arel library.

The main benefits of using Arel are that it is easy to read and to reuse by encapsulating queries or parts of queries in methods. Moreover, you can mix Arel with plain Active Record to create queries that are even more straightforward.

Note that Arel is a relatively new library and might be subject to modifications in the future. This makes some developers reticent to using Arel, but at the end, it is part of the Rails project journey and who knows [what the next version of Rails could include](https://www.bootrails.com/blog/rails-8-unreleased-features/).