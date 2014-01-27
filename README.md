bigAcalendar
============

Easily create custom, giant-sized calendars. 

The basic idea is that a calendar is built using a template of what each date is supposed to look like.

Still has some work to do but this is a good start.

Requires RMagick to be installed.

If you are on a Mac and use homebrew (both should be true), you can install it with:

Install ImageMagick library
brew install imagemagick 

Install the Ruby gem
gem install rmagick

It should then work fine, but if you get an error about annotate not having the necessary font, run:

brew install ghostscript
