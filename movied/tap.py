#!/usr/bin/python
# movied tap.py

from twisted.python import usage
import moviesvc

class Options(usage.Options):

    optParameters = [
        ['directory', 'd', '/c/movies'],
        ['port', 'p', '8000'],
        ]

def makeService(config):
    return moviesvc.MovieService(config['directory'], config['port'])
