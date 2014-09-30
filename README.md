bookshelf_experiment
====================

An experiment showing how rails can support encapsulation and single responsibility


This version simply moved User, Book and Ownership into People , Library and Bookshelf engines.

We are still using active record directly.

People and Library know nothing of each other so they can't have cross engine associations.

Bookshelf knows about People and Library.

We start using acts as taggable models directly rather than mixing it into the User and Book models. This is because we want to reduce dependencies anywhere possible.  Notice that the join on books and users starts to happen in the controller.  Could be an interesting conversation on whether this is acceptable. If Tagging was a service then you would have no other way.

( i did try to mixin acts as taggable on the instances rather than the class method, couldn't figure it out. )

I didn't do any testing here other than my little test script which executes the http api.

