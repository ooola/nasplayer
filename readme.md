Roku NAS Player
===============

This is a simple movie player for the [roku](http://www.roku.com).

The roku player app has not been submitted to the roku as a **channel** app. The
only way to get the app on your roku is to put it in developer mode and
side-load the app.

The player needs a server to feed it XML listings of content and an HTTP server
to stream videos from. This is done by the movie daemon (movied). Just run
**./xml_movies.py**. A good place to run this is on a NAS where media content
(movies) are stored.

Why not use plex?
-----------------
I didn't want a heavy weight setup like [Plex](http://plexapp.com/roku/). I
just needed a very basic setup to stream local content to the roku. If you want
something fully featured I recommend Plex.

Working with the Roku and Roku SDK is also quite enjoyable, it is a very
carefully thought out system.

By Ola Nordstrom. 

Licence (Simplified BSD License)
--------------------------------

Copyright (c) 2013, Ola Nordstrom
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
(c) 
