Some background
===============

I'm [Undo](http://stackexchange.com/users/1703573/undo). A few months back I commited to [Space Exploration](http://space.stackexchange.com), a site still going strong.

It all started when one of our Diamond moderators asked for more flags on obsolete comments. So, of course, I started flagging things.

At first, obsolete comments were easy to come by. As I kept flagging them, however, they started going away (of course). With the easy pickings gone, I needed a way to find the older, more discreet obsolete comments.

This is what I came up with.

SECommentFlagger
----------------

This is an OS X app for finding comments on Stack Exchange to flag - awesome for driving those ♦ mods crazy. It allows you to specify a site API key. The app will then fetch all the comments on the site (to a limit you set). After this, the app allows you to search for comments.

Instructions
-------------

 - Build the app (Xcode to the rescue!) 
 - Input a site API key (stackoverflow, space, security, etc.)
 - specify a `max` and a `start`. The `max` tells the app how many comments to get, and the `start` tells it which page to start at.

License
--------

This is licensed under [GPL v2](http://choosealicense.com/licenses/gpl-v2). 

Have fun!
