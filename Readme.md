Lossless reduction for js, css, html, xml, jpg, png, gif

Only for https://gist.github.com/ack43/4c7498ff2a53d41cba76d2ab66b4287e

Install
=======
    install ruby + rubygems
    sudo gem install reduce

Usage
=====
    reduce -o public/image.gif
    reduce public/javascripts/application.js > public/javascripts/application.min.js

Options
=======
    -o, --overwrite                  overwrite file
    -v, --version                    Show Version
    -h, --help                       Show this.

Ruby
====
    reduced_data = Reduce.reduce('files/bla.js')

How does it work?
=================
 - uses web-based lossless image reduction service [Smush.it](http://smush.it) / [PunyPng](http://www.gracepointafterfive.com/punypng) through [smusher](http://github.com/grosser/smusher)
 - uses [Closure compiler](https://developers.google.com/closure/compiler/) to minify js
 - uses [YUI compressor](https://developer.yahoo.com/yui/compressor/) to minify css
 - uses [htmlcompressor](https://code.google.com/p/htmlcompressor/) to minify html/xml


Author
======

### [Contributors](https://github.com/grosser/reduce/contributors)
 - [Emanuele Bardelli](https://github.com/pacbard)

Michael Grosser<br/>
grosser.michael@gmail.com<br/>
License: MIT
