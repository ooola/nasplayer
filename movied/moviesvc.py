#!/usr/bin/python
#
# a simple twisted webserver the responds with XML movie listings
#

# system imports
import sys

# twisted imports
from twisted.application import internet, service
if sys.version_info[:2] == (2,3):
    # ReadyNAS runs python 2.3
    from twisted.protocols import http
else:
    from twisted.web import http

# local imports
import xml_movies


class MovieRequestHandler(http.Request):
    """ Handles requests for movie listings """

    # pages is a listing of URLs and the corresponding
    # function in xml_movies that will return the XML doc
    pages = {
        '/movies/v1': 'get_xml_video_list',
    }

    def __init__(self, NEWDIR, *args):
        self.directory = NEWDIR
        http.Request.__init__(self, *args)

    def process(self):
        if self.pages.has_key(self.path):
            func = getattr(xml_movies, self.pages[self.path])
            movie_list = func(self.directory)
            self.write(movie_list.toxml())
        else:
            self.setResponseCode(http.NOT_FOUND)
            self.write("<h1>Not Found</h1>Sorry, no such page.")
        self.finish( )

class MovieHttp(http.HTTPChannel):

    def __init__(self, directory):
        self.directory = directory
        http.HTTPChannel.__init__(self)

    def requestFactory(self, *args):
        return MovieRequestHandler(self.directory, *args)

class MovieHttpFactory(http.HTTPFactory):

    def __init__(self, directory):
        self.directory = directory
        http.HTTPFactory.__init__(self)

    def buildProtocol(self, directory):
        return MovieHttp(self.directory)

class MovieService(internet.TCPServer):
    def __init__(self, directory, port):
        self.directory = directory
        internet.TCPServer.__init__(self, port, MovieHttpFactory(self.directory))

if __name__ == "__main__":
    try:
        directory = sys.argv[1]
        from twisted.internet import reactor
        reactor.listenTCP(8000, MovieHttpFactory(directory))
        reactor.run()
    except IndexError:
        print "usage:", sys.argv[0], "<video directory>"
