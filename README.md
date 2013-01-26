nomnomnom
=========

##NOUNS
```
artist
band
feeling
genre
song
user
```

##RELATIONSHIPS
```
[ text ] 						  #is 		  [ all nouns ]
[ album | song | band | artist ] #feels 	  [ feeling ]
[ artist | band ] 				  #influences [ artist | band ]
								  #love 	  [ all nouns ]
								  #hate 	  [ all nouns ]
[ artist ] 						  #in 		  [ band | genre ]
[ band ] 						  #in 		  [ genre ]
[ artist | band ] 				  #performs   [ song ]
[ artist | band ] 				  #wrote 	  [ song ]
```

##VALIDATION
* ascii only (for now)
* 32 chars max

##SANITIZATION RULES
* lowercase
* trim
* white space seperators reduced to 1 character



Credits
-------

* Many thanks to [Rod McFarland](http://thrind.xamai.ca/) for his original [CLI2](http://code.google.com/p/wordpress-cli/). The JavaScript CLI implementation in cli.js is a heavily modified version of the CLI2 client-side logic. CLI2 is Copyright © [Rod McFarland](http://thrind.xamai.ca/), 2006, 2007, 2008.


License
-------

* The unixkcd code is released under  the [GNU GPLv2](http://www.gnu.org/licenses/gpl-2.0.html).

* YUI Compressor is distributed under a [BSD license](http://developer.yahoo.com/yui/license.html), with [Rhino](http://www.mozilla.org/rhino/) components licensed under [MPL](http://www.mozilla.org/MPL/).
