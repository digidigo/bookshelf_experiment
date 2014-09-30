bookshelf_experiment
====================

An experiment showing how rails can support encapsulation and single responsibility

In this version we have moved all code into the individual engine classes. We could and should have used libraries here, but chose minimal.

We moved acts as taggable into an engine as well, this is a good example of a service that knows nothing of the objects that it is responsible for tagging.  What we loose is the join in the DB. 

I wasn't totally happy with the names of methods,  could have used more time and more voices in choosing them.

More to do here:

* api_controller should be in an engine itself
* all engine methods should return Hashes , or some common data object that is AR compliant. , they should not leak out AR objects.
* a clear opinion about how to name methods or to stick with AR stuff.
* better api design for sure


