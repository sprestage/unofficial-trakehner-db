# README

## Unofficial Trakehner Database
http://www.unofficialtrakehnerdatabase.com

A Ruby on Rails website designed to address the challenges facing the Trakehner horse enthusiast when researching various horse statistics with emphasis for Trakehner breeders.  This Rails 7 application uses Ruby, Rails, HTML, CSS, Javascript, jQuery, Twitter Bootstrap, PostgreSQL, and many gems to implement the various needed features.  

• Use of AWS for CNAME, DNS, and S3 hosting of the horse images.
• Basic i18n support for German.
• Implemented tables using simple_form gem for simplicity and straightforwardness of page design.  (remember this is an older site and thus has an older look)


### Project Idea
=======
To implement a website for the Trakehner horse enthusiast, with emphasis for Trakehner breeders.


### Motivation
=======
Performing research on the bloodlines of various Trakehners can be
very tedious.  Almost none of the historical Trakehners have pages,
so most of the horses in a given pedigree have no links to further
information, just a name.  As a horse breeder, I want to easily look
up pertinent data (pedigree, performance records, photos, inspection
results, etc) for every ancestor and every descendant of any given
Trakehner horse.  I want this accessible on the web.  I want it fast
and easy.  I want it available for everyone to read.  I want only the
owner of a horse to be able to change/enter data.  It should not be
possible for a user to delete a horse entirely, this should probably
be an admin task to correct for gross mistakes or duplications.

This site is my solution to those problems.


### Technical Details
=======

Uses Rails 7.0.8 and Ruby 3.1.3


### Deployment
=======
This project has been deployed to Render.com which then points to the custom domain http://www.unofficialtrakehnerdatabase.com.


### Current status
The Unofficial Trakehner Database has been around since 2013 and started out life as a rails 3 app.  Sometimes a legitimate upgrade from one rails version to another occurred.  But twice now, it has been more straightforward to simply create a new, basic rails app of the appropriate modern version and then port over only the pieces that are relevant to the site.   This latest revision has the data from 2013, but is awaiting the more recent data from 2024.

Version 3 is this repository, using rails 7, https://github.com/sprestage/unofficial-trakehner-db.
Version 2 using rails 4 and then rails 5: https://github.com/sprestage/trakehner-db-new
Version 1 using rails 3: https://github.com/sprestage/trakehner-db

Please refer to the v1 and v2 repositories for full history of this passion project.

This project was updated to rails 7 and moved to render.com as a result of the sunsetting of the supporting heroku.com infrastructure.


### Steps to create

```
chruby 3.1.3

rails new unofficial-trakehner-db --minimal --database=postgresql
cd unofficial-trakehner-db
chruby 3.1.3

rails db:create
rake db:migrate

RAILS_ENV=development rails s

RAILS_ENV=development bundle exec rake import_stallion_images

```


### Implementation Tasks
=======
#### This list of task was copied over from the old project.  Update as needed.

- [x] Re-implement basic site
- [x] Re-add static pages
- [x] Re-add model for Horses
- [x] Re-add controller for Horses
- [x] Re-add migrations for Horses
- [x] Confirm database functionality and implementation of the Horse migrations
- [x] Re-add Index Horses view
- [x] Re-add Show Horse view
- [x] Confirm functionality and fix issues for Index of Horses, with and without thumbnail
- [x] Confirm functionality and fix issues for Show Horse, without image(s)
- [x] Re-implement ATA logo on Show Horses page
- [x] Confirm functionality and fix issues for Show Horse, with image(s)
- [x] Re-implement pedigree
- [x] Import ATA approved stallions
- [x] Re-implement horse images
- [x] Re-implement home page with ATA approved stallion carousel
- [x] Re-implement ATA logo on home page
- [x] Re-implement ATA logo on Index Horses page
- [ ] Re-add internationalization
- [ ] Re-add model for Breeders
- [ ] Re-add controller for Breeders
- [ ] Re-add migrations for Breeders
- [ ] Confirm database functionality and implementation of the Breeder migrations
- [ ] Re-add Index Breeders view
- [ ] Re-add Show Breeder view
- [ ] Confirm functionality of Breeder views (index, show)
- [ ] Re-implement Horse tests
- [ ] Re-implement Breeder tests
- [ ] Re-implement population of database with horses and breeders from json, locally
- [ ] check for the bugs mentioned below, locally
- [ ] port all this to the hacienda-solutions-terraza repository (under new branch!!!)
- [ ] get the UTDB running again under the Terraza
- [ ] deploy Terraza and get the DB up and running with the stallions data
- [ ] Deploy new UTDB to production with note of explanation that the data is currently 2013 stallions only and what the next steps for the data imports are
- [ ] Import json data and ATA stallions on Render
- [ ] Bug with progeny.  Probably due to the need for the ancestry gem to handle the multiple foreign key problem with the progeny of Horse.  See the json files for C and A for the stallion Almox Prints J.  Update: Good news.  Offspring/Progeny is working beautifully.  belongs_to automatically carries the association in the other direction, so a has_many for offspring within the horse model is not needed and has been removed.  The worrisome indicator I saw was only due to not having imported all the json files yet.
- [ ] Import all json data on Render, letter by letter, trying to avoid maxing out the database inserts for the free level of database.  Over 23,000 inserts into database.  Render is not happy and will permit no others, but the site is stable without the need to change the DB (for now).
- [ ] Need to upgrade from Render's free Hobby-dev database to the $9/month Hobby-basic database.  This should be done when the updated horse json data scraping is performed on the ATA website.
- [ ] Re-scrape the ATA website to get the new horses.  Probably need to scrape all data, then the rake script will need to check both that the horse/breeder exists and also that any data for that horse/breeder has changed.  If data is unchanged, the save should not be made.  
- [ ] Improve i18n on Show Horse page (and "Home" button)
- [ ] There is a stallion, Absalon, who looks to be from Germany whose gender is "V".  Figure out the German translations for Stallion, Gelding, and Mare.  Examine data for FRG or ??? in the Breeder name and check gender for these horses, correcting as needed.  NEED TO DO THIS BEFORE POPULATING HEROKU!!!\
- [ ] Fix McGill vs Mcgill.  Consider upcasing.
- [ ] Add photo credit, see horse Ballzauber, https://unofficialtrakehnerdb.s3-us-west-2.amazonaws.com/ata_approved_stallions/BallzauberPhotoCredit.txt
- [ ] Fix location of language toggle.  Should be on far right.  Hmmm.  Fixed on Render (in production), with correct fonts which are all missing locally.  Priority on this is much lower as a result but should be looked into at some point.
- [ ] When a horse sire or dam is Unknown, the name 'Unknown' is not a link.  However, when a breeder name is 'Unknown', it is still displayed as a link, which then brings up every horse whose breeder is unknown. Change the 'Unknown' breeder name to no longer be displayed (or function) as a link.
- [ ] Re-implement image uploader for Horses.  This is already done.  All images and thumbnails are stored in AWS S3.  When the json is imported into the database, the URLs for images and thumbnails are populated accordingly.    Here is an example thumbnails - https://unofficialtrakehnerdb.s3-us-west-2.amazonaws.com/uploads/horse/image/1001/thumbnail_Martini.jpg *<- 2024-03-13, might be obsolete -susan*
- [ ] Re-implement fonts *<- 2024-03-13, might be obsolete -susan*
- [ ] Remove or comment out all devise and auth-related code related to Breeder model *<- 2024-03-13, might be obsolete -susan*


### Testing
=======

To run all tests except those in /test/system, type the following at the command line:
~~~~
  $ rake test
~~~~
Note: <code>rake test:all</code> was deprecated as of rails 4.2.

To run system tests:
~~~~
  $ rake test:system
~~~~

To run all tests including system tests:
~~~~
  $ rake test:system test
~~~~

To run a single test file, do this:
~~~~
  $ rake test TEST=test/controllers/home_page_test.rb
~~~~

If you get a message like this:
~~~~
  rake aborted!
  PG::ConnectionBad: could not connect to server: Connection refused
      Is the server running on host "localhost" (::1) and accepting
      TCP/IP connections on port 5432?
~~~~
your postgresql is probably not running.  This can be checked using:
~~~~
  $ pg_ctl -D /usr/local/var/postgres status
~~~~
To start postgresql, use a command like this:
~~~~
  $ pg_ctl -D /usr/local/var/postgres -l ~/postgres-server.log start
~~~~


### Policy and roles plan - This is currently removed and still under consideration for the future.
=======

<pre>
Five eventual roles:

    visitors to the site -  can look and search horses and breeders;
                            cannot see new h/b, edit h/b, delete h/b,
                            cannot see sign up anywhere.
                            sign up new users is only by email to me
                            ...this is the way the ATA does it.
    owners -    can see edit horses they own only (will eventually include
                  editing horse
                owner info)
                cannot see new h/b, edit breeder, delete h/b
    breeders -  can edit self
                cannot see new h/b, edit horse, edit breeders other than
                self cannot see delete horse/breeder, sign up
    ata -   can see edit horse and edit breeder
            cannot see new or delete h/b (we should reconsider this when
            the time comes)
    admin - me
            can see all the things
</pre>



Database info
=======

~~~~
  $ psql postgres

  postgres=# create user postgres with password 'postgres';
  postgres=# alter user postgres with superuser;
  postgres-# \q

  $ rake db:create
  $ rake db:migrate

  $ dropdb db/trakehner_dev

~~~~


Thumbnails
=======
https://alvinalexander.com/mac-os-x/batch-thumbnails-images-photos-free-mac-osx/
