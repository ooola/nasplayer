
Function getMovieList() As Object
    http = CreateObject("roUrlTransfer")
    http.SetUrl("http://192.168.1.111/movies/movies.xml")
    xml=http.GetToString()
    rsp=CreateObject("roXMLElement")
    if not rsp.Parse(xml) then stop
    
    'rsp.GetBody().Peek().GetBody())
    return helperMovieListFromXML(http, rsp.movies.movie)
End Function

Function helperMovieListFromXML(http As Object, xmllist As Object) As Object
    movielist=CreateObject("roList")
    for each movie in xmllist
        movielist.Push(newMovieFromXML(http, movie))
    end for
    return movielist
End Function

'
' newMovieFromXML
'
' Takes an roXMLElement Object that is an <movie> ... </movie>
' Returns an brs object of type Movie
'
Function newMovieFromXML(http As Object, xml As Object) As Object
    movie = CreateObject("roAssociativeArray")
    movie.http=http
    movie.xml=xml
    movie.Title=xml@Title
    print xml@ShortDescriptionLine1
    movie.ShortDescriptionLine1= xml@ShortDescriptionLine1
    movie.ShortDescriptionLine2= xml@ShortDescriptionLine2
    'movie.StreamFormat=function():return xml@StreamFormat:end function
    movie.StreamFormat= xml@StreamFormat
    'movie.HDPosterUrl=function():return xml@HDPosterUrl:end function
    'movie.SDPosterUrl=function():return xml@SDPosterUrl:end function
    movie.StreamUrls = [ xml@url ]
    movie.StreamBitrates = [0]
    movie.StreamQualities = [ "HD" ]
    print "Adding new movie"
    printMovie(movie)
    return movie
End Function

Function printMovie(movie As Object)
    print ""
    print "Title: "; movie.Title
    print "ShortDescriptionLine1: "; movie.ShortDescriptionLine1
    print "ShortDescriptionLine2: "; movie.ShortDescriptionLine2
    print "StreamFormat: "; movie.StreamFormat
    print "HDPosterUrl: "; movie.HDPosterUrl
    print "SDPosterUrl: "; movie.SDPosterUrl
    print "StreamQualities: "; movie.StreamQualities[0]
    print "StreamBitrates: "; movie.StreamBitrates[0]
    print "StreamUrl: "; movie.StreamUrls[0]
End Function
