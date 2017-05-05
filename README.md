# _Volunteer Tracker_

#### _Ruby week3 independent project, 05/05/2017_

#### By _**Chitroopa Manikkavasagam**_

## Description

_This application tracks projects and the volunteers working on them. Each volunteer will belong to only one project (one project, many volunteers)._

_The following user stories are completed:_

* _As a non-profit employee, I want to view, add, update and delete projects._
* _As a non-profit employee, I want to view, add, update and delete volunteers._
* _As a non-profit employee, I want to add volunteers to a project._
* _Add a method that calculates how many total hours all volunteers have put into a single project._

## Setup/Installation Requirements

* _Clone this repository_
* _Give $ bundle command to install all required gems_
* _Follow the database setup instructions below and create database_
* _This application uses Sinatra server, give $ ruby app.rb to start the server_
* _Open your browser, type http://localhost:4567 and hit enter_

## Database setup instructions

In PSQL: enter the following to create a new database

CREATE DATABASE volunteer_tracker;

CREATE TABLE projects (id serial PRIMARY KEY, name varchar, hours int);

CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar,hours int, phone_number varchar, project_id int);

## Known Bugs

_NA_

## Technologies Used

_Ruby, HTML, CSS_

_Ruby gems : Sinatra, pry, capybara, rspec_

### License

*MIT*

Copyright (c) 2017 **_Chitroopa Manikkavasagam_**
