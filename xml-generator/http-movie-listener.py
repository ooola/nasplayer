#!/usr/bin/python
#
# a simple twisted webserver the responds with XML movie listings
#

# system imports
import sys

# twisted imports
from twisted.internet import reactor
if sys.version_info[:2] == (2,3):
    from twisted.protocols import http
else:
    from twisted.web import http

# local imports
import xml_movies

class MyRequestHandler(http.Request):
    """ Handles requests for movie listings """

    # pages is a listing of URLs and the corresponding
    # function in xml_movies that will return the XML doc
    pages = {
        '/movies/v1': 'get_xml_video_list',
    }

    def process(self):
        if self.pages.has_key(self.path):
            func = getattr(xml_movies, self.pages[self.path])
            movie_list = func(directory)
            self.write(movie_list.toxml())
        else:
            self.setResponseCode(http.NOT_FOUND)
            self.write("<h1>Not Found</h1>Sorry, no such page.")
        self.finish( )

class MyHttp(http.HTTPChannel):
    requestFactory = MyRequestHandler

class MyHttpFactory(http.HTTPFactory):
    protocol = MyHttp

if __name__ == "__main__":
    try:
        global directory
        directory = sys.argv[1]
        reactor.listenTCP(8000, MyHttpFactory())
        reactor.run()
    except IndexError:
        print "usage:", sys.argv[1], "<video directory>"
