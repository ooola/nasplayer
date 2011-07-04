

'*************************************************************
'** displayVideo()
'*************************************************************

Function displayVideo2(movie As Object)
    print "Displaying video: "
    p = CreateObject("roMessagePort")
    video = CreateObject("roVideoScreen")
    video.setMessagePort(p)

    'bitrates  = [0]          ' 0 = no dots, adaptive bitrate
    'bitrates  = [348]    ' <500 Kbps = 1 dot
    'bitrates  = [664]    ' <800 Kbps = 2 dots
    'bitrates  = [996]    ' <1.1Mbps  = 3 dots
    'bitrates  = [2048]    ' >=1.1Mbps = 4 dots
    bitrates  = [0]    

    if type(args) <> "roAssociativeArray"
        print "args is not an roAssociativeArray, returning"
    '    return
    end if

    print "displayVideo2 playing movie"
    printMovie(movie)

    video.SetContent(movie)
    video.show()

    lastSavedPos   = 0
    statusInterval = 10 'position must change by more than this number of seconds before saving

    while true
        msg = wait(0, video.GetMessagePort())
        if type(msg) = "roVideoScreenEvent" then
            print "showVideoScreen | msg = "; msg.GetMessage() " | index = "; msg.GetIndex()
            if msg.isScreenClosed()
                print "Screen closed"
                exit while
            else if msg.isStatusMessage()
                print "status message: "; msg.GetMessage()
            else if msg.isPlaybackPosition()
                print "playback position: "; msg.GetIndex()
            else if msg.isFullResult()
                print "playback completed"
                exit while
            else if msg.isPartialResult()
                print "playback interrupted"
                exit while
            else if msg.isRequestFailed()
                print "request failed – error: "; msg.GetIndex();" – "; msg.GetMessage()
                exit while
            end if
        end if
    end while
End Function
