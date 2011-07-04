#!/usr/bin/python
#

#system imports
import sys

# twisted imports
from twisted.application import service

# local imports
from moviesvc import MovieService

application = service.Application("MovieService")
mService = MovieService("/nas/movies", 8000)
mService.setServiceParent(application)

if __name__ == '__main__':
    try:
        print "calling main"
        #print get_xml_video_list(sys.argv[1]).toprettyxml(indent="  ")
    except IndexError:
        print "usage:", sys.argv[0], "<movie directory>"
