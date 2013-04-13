#!/usr/bin/python
#
# xml parsing utilities
#

import sys
import os
import urllib

from xml.dom.minidom import Document

baseurl = "http://192.168.1.111/movies/"

def get_xml_video_list(directory=None):
    doc = Document()
    rsp = doc.createElement("rsp")
    doc.appendChild(rsp)
    movies = doc.createElement("movies")
    rsp.appendChild(movies)
    if directory != None:
        for movie in get_movie_list(directory):
            m = doc.createElement("movie")
            m.setAttribute("Title", movie)
            m.setAttribute("ShortDescriptionLine1", movie)
            m.setAttribute("ShortDescriptionLine2", movie)
            m.setAttribute("StreamFormat", "mp4")
            m.setAttribute("HDPosterUrl", "")
            m.setAttribute("SDPosterUrl", "")
            m.setAttribute("url", baseurl + urllib.quote(movie))
            movies.appendChild(m)
    return doc

def get_movie_list(directory=None):
    """Returns a yield'ed list of movies (mp4 and m4v) in the given directory"""
    files = os.listdir(directory)
    for f in files:
        if f[-4:] == ".mp4" or f[-4:] == ".m4v" or f[-4:] == ".mov" or f[-4:] == ".avi":
            yield f

if __name__ == '__main__':
    try:
        print get_xml_video_list(sys.argv[1]).toprettyxml(indent="  ")
    except IndexError:
        print "usage:", sys.argv[0], "<movie directory>"
