GeoIP @PSIORI
=============

Geolocation from IP for PISORI.

This web service provides a simple to use REST API for searching geolocation of IP addresses.
Internally, this service uses databases of www.MaxMind.com and the service www.freegeoip.com.


Deployment
----------

This package can be easily deployed to geoip.psiori.com using the following capistrano
command:

```
  bundle exec cap production deploy
```

There are further commands to start|stop|restart the service:

```
  bundle exec cap production deploy:start
  bundle exec cap production deploy:stop
  bundle exec cap production deploy:restart
```

Please note that this service uses memcached to cache IP requests. Thus, memcached needs
to be up and running. If it's not available, simply remove the line
```
  config.cache_store = :mem_cache_store
```
from config/environments/production.rb

  
Database
--------

The database is NOT included in this app as this would violate 3rd party licenses. There's
a script for fetching the original data, compiling it and adding it to the database in
script/freegeoip_db/ named updatedb.rb . It relies on the other scripts and files in the 
same directory.

You can update the database on the production server using a capistrano task:

```
  bundle exec cap production deploy:update_db
```
  
This command will take several minutes to complete. During the update, the geo resolution
will not work properly (should be changed later).

MaxMind presently updates their data on the 1st of every month.


Usage
-----

You use the service by sending simple HTTP GET requests to a single endpoint:

```
  GET /api/v01/ip/{ipv4}
```

Just fill in the IPv4 address that should be resolved at the end of the URL. 

The service will answer with a JSON hash of the form
```
  {
    "ip"           : "87.176.174.189",
    "country_code" : "DE",
    "city"         : "Freiburg",
    "latitude"     : "48.0",
    "longitude"    : "7.85"
  }
```

There's a running instance 


Contributors
------------

Sascha Lange - sascha@5dlab.com