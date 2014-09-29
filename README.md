bookshelf_experiment
====================

An experiment showing how rails can support encapsulation and single responsibility

This is a simple application.

It keeps track of User, Books, the Books that Users own.  It also allows for Users to Tag Books and then search for Users or Books by Tag.

The HTTP API is all in a single controller and the routes are all explicitly defined.

The purpose of this experiment is to refactor a simple Rails application in order to embrace single responsibility and encapsulation. 

There are 3 branches.  master , engine refactor and encapsulation refactor.  Check them out in that order and read through api_controller

There will be a number of comments throughout api_controller, hopefully they will provide some food for thought.

All of this could be taken further, the minimum amount was done in order to show how the concepts could be implemented.

