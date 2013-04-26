Mapping levees and their stability using the interwebs
======================================================

:date: 2013-05-01
:category: écologie,informatique,électronique
:level: découverte
:author: Fritz van Deventer
:translator: Tarek Ziadé

Intro
-----

In the Netherlands water security is probably the major water issue the country
faces as 26% of the country and around 60% of the population is located below
sea level, this becomes an issue of national security.


.. figure:: http://www.ijkdijk.nl/images/Grechtdijk2.jpg

   source: http://www.ijkdijk.nl/nl/livedijken/livedijk-utrecht

Levees, or dikes, serve as a main protection against this water. In the year
2013 it no longer suffices to send people around to the dikes themselves. The
levees are now equipped with all kinds of sensors as can be seen in the image
below. Sensors are embedded in the levee to make an intelligent artifact.


Data Center
-----------

As a datum the IJkdijk foundation built a levee with all kinds of sensors that
could and has been breached without any real danger. The data the sensors
yielded now serves as a baseline (IJkdijk is Dutch for: Calibration Levee).

.. figure:: http://www.beeldsite.nl/ijkdijk/20080928ijkdijk/slides/DSC04627.JPG

   source: http://www.ijkdijk.nl/en/experiments/macrostability

If all levees are to be equipped with these sensors this will result in
mountains of data to keep track of. At http://nelen-schuurmans.nl we tried to
solve this part of the story. With the Dijk Data Service Center (levee data
service center), we built a system to store and display all this data.


Data Storage & Collection
-------------------------

All kinds of sensors are being crammed into the levees: temperature, soil
moisture content, acidity etc. These sensors are managed by another party so
the real technical of that side of the story can be found on
http://www.ijkdijk.nl/en/ . When the sensors have collected their data it can
be delivered to our servers in several ways. It can be uploaded to an FTP
server, connected to a Socket Server that listens to new incoming data, it can
be imported through a specific XML document. Basically our client can toss
anything with numbers and dates at us and we slurp it up. can talk to our REST
API. The sensor data is stored in Cassandra nodes
(http://cassandra.apache.org/) with the metadata and the latest values cached
in a Postgres/PostGIS database.

Our REST API is built around the Django REST Framework, because we all know
Python and Django at our office. This might not be the best solution for what
we wanted to do. But hey, you live you learn.

Because our API relied heavily on Django, we decided to use django-haystack in
combination with Solr for search capabilities.

Web client
----------

Our webclient gets its data from the same REST API that the sensors can talk
to. The main thing to tackle here was displaying data as information to the
user. Condensing a few million data points to meaningful information. The data
is not only temporal it is also carries spatial significance. In stead of just
delivering a big sandbox of data points we have decided to help the user focus
on important things.

* Warnings that trigger at certain threshold values
* Preset graphs and map ensembles
* Search functions using Solr

The graph had the potential of becoming extremely hefty. As at any given point
in time the amount of data points could be tremendous. By using the
Douglas-Peucker algorithm we dodged the bullet of over plotting a low-res
screen. We send the viewport of the graph to the server and it returns an array
that simplifies the graph line for that viewport.

The map view was kind of difficult to come up with, because in quite a limited
space, lots of different sensors are collecting data. How do you categorize,
how does one go through these points, while still making sense of what is going
on? We made a distinction between technical and non-tecnical staff that has to
attend this system. There are certain pre-set modes with the flexibility of
clicking together a map or a graph overview.

The client was made using Backbone.js and an extension for it: Marionette.js.
This was quite a new thing for us as we have mostly done all our templating and
data collection server side. When a big project comes along, it's nice to try
out a new technology which might be useful in the future. The async JSON
sending with a MVC such as Backbone really helped us out, especially in the
overview of the timeseries and the plotting of the data. However the debate on
what should happen in the client or what should happen on the server side of
things is far from over. Especially Backbone is very verbose. Maybe a framework
like Angular would have been a more lightweight solution.

Final thoughts
-------------

We're still figuring out a "simple" solution of getting live data into a
webclient that both specialists and (non-technical) decision makers can use.
But we have made a lot of headway by:

* Introducing pre-set graphs instead of the clutter that an "We want excel in
  the browser" interface can give
* Only allowing to plot as much data points as there are pixels in the viewport
  of the user
* Displaying information when necessary.

Check us out on http://github.com/ddsc/ or on http://dijkdata.nl

