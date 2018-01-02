# _:sunflower: LIBRARY! :sunflower:_

## Library tracker - Ruby - 9.20.17

## By Sara Spink and Margaret Berry

## Description:
LIBRARY! is a program to catalog a library's books and let patrons check them out.

## Project Goals
* _Design a database schema with a one-to-many relationship._
* _Practice writing methods to enable CRUD functionality._
* _Practice manipulating data in an SQL database._

## Future Features
* _Create a checkouts table that is a join table between books and patrons._

## Setup/Installation
1. _Install Postgres by running the following commands in Terminal:_
  - `$ brew install postgres`
  - `echo "export PGDATA=/usr/local/var/postgres" >> ~/.bash_profile` _This tells Postgres where to find the stored database._
  - `echo "export PGHOST=/tmp" >> ~/.bash_profile` _This enables some programs to find Postgres._
  - `source ~/.bash_profile` _This loads the configuration changes._
2. ` $ postgres`
3. _In a separate terminal window:_ `$ psql`
4. `CREATE DATABASE library_test`
5. `\c library_test`
6. `CREATE TABLE books (name varchar, id serial PRIMARY KEY)`
7. `CREATE TABLE authors (name varchar, id serial PRIMARY KEY)`

## User Stories
* _As a librarian, I want to create, read, update, delete, and list books in the catalog, so that we can keep track of our inventory._
* _As a librarian, I want to search for a book by author or title, so that I can find a book easily when the book inventory at the library grows large._
* _As a librarian, I want to see a list of overdue books, so that I can call up the patron who checked them out and tell them to bring them back._
* _As a librarian, I want to enter multiple authors for a book, so that I can include accurate information in my catalog._

* _As a patron, I want to check a book out, so that I can take it home with me._
* _As a patron, I want to see a history of all the books I checked out, so that I can look up the name of that awesome sci-fi novel I read three years ago._
* _As a patron, I want to know when a book I checked out is due, so that I know when to return it._

## Technologies Used
- Ruby
- Sinatra
- Postgres

## Support and contact details
_If you have any updates or suggestions please contact Sara Spink or [Margaret Berry](codeberry1@gmail.com) or make a contribution to this repository._

### License
*This software is licensed under the MIT license.*

Copyright (c) 2017 **_Margaret Berry and Sara Spink_**

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.*
