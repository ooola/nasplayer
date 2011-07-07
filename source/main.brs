' *********************************************************
' **  Simple Poster Screen Demonstration App
' **  Nov 2009
' **  Copyright (c) 2009 Roku Inc. All Rights Reserved.
' *********************************************************

'************************************************************
'** Application startup
'************************************************************
Sub Main()

    'initialize theme attributes like titles, logos and overhang color
    initTheme()

    'prepare the screen for display and get ready to begin
    screen=preShowPosterScreen("", "")
    if screen=invalid then
        print "unexpected error in preShowPosterScreen"
        return
    end if

    'set to go, time to get started
    showPosterScreen(screen)

End Sub


'*************************************************************
'** Set the configurable theme attributes for the application
'** 
'** Configure the custom overhang and Logo attributes
'** These attributes affect the branding of the application
'** and are artwork, colors and offsets specific to the app
'*************************************************************

Sub initTheme()

    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")

    theme.OverhangOffsetSD_X = "72"
    theme.OverhangOffsetSD_Y = "25"
    theme.OverhangSliceSD = "pkg:/images/overhang_backgroundslice_black_SD.png"
    theme.OverhangLogoSD  = "pkg:/images/logo_overhang_rlocal_movies_SD.png"

    theme.OverhangOffsetHD_X = "123"
    theme.OverhangOffsetHD_Y = "48"
    theme.OverhangSliceHD = "pkg:/images/overhang_backgroundslice_black_HD.png"
    theme.OverhangLogoHD  = "pkg:/images/logo_overhang_rlocal_movies_HD.png"

    app.SetTheme(theme)

End Sub

'******************************************************
'** Perform any startup/initialization stuff prior to 
'** initially showing the screen.  
'******************************************************
Function preShowPosterScreen(breadA=invalid, breadB=invalid) As Object

    port=CreateObject("roMessagePort")
    screen = CreateObject("roPosterScreen")
    screen.SetMessagePort(port)
    if breadA<>invalid and breadB<>invalid then
        screen.SetBreadcrumbText(breadA, breadB)
    end if

    screen.SetListStyle("arced-landscape")
    return screen

End Function


'******************************************************
'** Display the poster screen and wait for events from 
'** the screen. The screen will show retreiving while
'** we fetch and parse the feeds for the show posters
'******************************************************
Function showPosterScreen(screen As Object) As Integer

    showList = getMovieList()
    screen.SetContentList(showList)
    screen.Show()

    while true
        msg = wait(0, screen.GetMessagePort())
        if type(msg) = "roPosterScreenEvent" then
            print "showPosterScreen | msg = "; msg.GetMessage() " | index = "; msg.GetIndex()
            if msg.isListItemFocused() then
                print"list item focused | current show = "; msg.GetIndex()
            else if msg.isListItemSelected() then
                print "list item selected | current show = "; msg.GetIndex() 
                'if you had a list of shows, the index of the current item 
                'is probably the right show, so you'd do something like this
                item = showList[msg.GetIndex()]
                'm.curShow = displayShowDetailScreen(item)
                'displayBase64()
                'playMovie(item)
                'displayVideo(item)
                displayVideo2(item)
            else if msg.isScreenClosed() then
                return -1
            end if
        end If
    end while


End Function

Function playMovie(movie as Object)
    print "Entering playMovie "
    print "The selected item is "; movie
    print "The movie shortdesc = "; movie.ShortDescriptionLine1
End Function

Function displayBase64()
    ba = CreateObject("roByteArray")
    str = "Aladdin:open sesame"
    ba.FromAsciiString(str)
    result = ba.ToBase64String() 
    print result

    ba2 = CreateObject("roByteArray")
    ba2.FromBase64String(result)
    result2 = ba2.ToAsciiString()
    print result2
End Function

'**********************************************************
'** When a poster on the home screen is selected, we call
'** this function passing an roAssociativeArray with the 
'** ContentMetaData for the selected show.  This data should 
'** be sufficient for the springboard to display
'**********************************************************
Function displayShowDetailScreen(category as Object, showIndex as Integer) As Integer

    print "Entering displayShowDetailScreen "
    print "catgeory = "; catgeory

    'add code to create springboard, for now we do nothing
    return 1

End Function



'********************************************************************
'** Given the category from the filter banner, return an array 
'** of ContentMetaData objects (roAssociativeArray's) representing 
'** the shows for the category. For this example, we just cheat and
'** create and return a static array with just the minimal items
'** set, but ideally, you'd go to a feed service, fetch and parse
'** this data dynamically, so content for each category is dynamic
'********************************************************************
Function getShowsForCategoryItem() As Object

    print "returning the feed " 

    showList = [
        {
            ShortDescriptionLine1:"Show #1",
            ShortDescriptionLine2:"Short Description for Show #1",
            StreamFormat:"mp4"
            url:"http://192.168.1.111/movies/The.Social.Network.m4v"
            Title:"The Social Network"
        }

        {
            ShortDescriptionLine1:"Show #2",
            ShortDescriptionLine2:"Short Description for Show #2",
            HDPosterUrl:"pkg:/media/bogusFileName_hd.jpg",
            SDPosterUrl:"pkg:/media/bogusFileName_hd.jpg"
        }
        {
            ShortDescriptionLine1:"Show #3",
            ShortDescriptionLine2:"Short Description for Show #3",
        }
    ]

    return showList

End Function
