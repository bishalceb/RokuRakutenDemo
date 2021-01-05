sub init()
    m.homeScreen = m.top.findNode("homeScreen")
    m.movieDetailPage = m.top.findNode("movieDetailPage")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.bgImage = m.top.findNode("bgImage")
    m.bgImage.width = m.screenWidth
    m.bgImage.height = m.screenHeight
    m.bgImage.uri = baseImageUrl()+"background_screen.png"
    onVisibleChange()
end sub

function onVisibleChange()   
    showHomeScreeen()
end function

function showHomeScreeen()
    m.homeScreen.visible=true
    m.movieDetailPage.visible=false
    m.videoPlayer.visible=false
end function

function showMovieScreeen()
    m.movieDetailPage.contentId=m.homeScreen.contentId
    m.homeScreen.visible=false
    m.movieDetailPage.visible=true
    m.videoPlayer.visible=false
end function

function showMovieScreeenFromPlayer()
    m.homeScreen.visible=false
    m.movieDetailPage.visible=true
    m.videoPlayer.visible=false
end function

function showPlayerScreeenFromHome()
    m.videoPlayer.contentId=m.homeScreen.contentId
    m.homeScreen.visible=false
    m.movieDetailPage.visible=false
    m.videoPlayer.visible=true
end function

function showPlayerScreeen()
    m.videoPlayer.contentId=m.movieDetailPage.contentId
    m.homeScreen.visible=false
    m.movieDetailPage.visible=false
    m.videoPlayer.visible=true
end function

'sub init()
'    m.bgImage = m.top.findNode("bgImage")
'    m.bgImage.width = m.screenWidth
'    m.bgImage.height = m.screenHeight
'    m.bgImage.uri = baseImageUrl()+"background_screen.png"
'    m.navStack = []
'    m.screens = m.top.findNode("screens")
'    m.navStack.push("HomeScreen")
'    
'    
'    'onVisibleChange()
'end sub
'
'sub addScreenToHistory(screen as object)
'    current = m.navStack.peek()
'    if current <> invalid then
'        current.visible = false
'    end if
'    
'    screen.observeField("close", "goBackInHistory")
'    
'    m.navStack.push(screen)
'    screen.visible = true
'    screen.setFocus(true)
'end sub
'
'function goBackInHistory() as boolean
'    screen = m.navStack.pop()
'    if screen <> invalid then
'        m.screens.removeChild(screen)
'        screen = m.navStack.peek()
'    if screen <> invalid then
'        screen.visible = true
'        screen.setFocus(true)
'    return true
'    end if
'    end if
'    return false
'end function
'
'function handleExitFromApp(isExitAppEvent as object)
'    isExitApp = isExitAppEvent.getData()
'    m.top.isExitFromApp = isExitApp
'end function
'
'function onKeyEvent(key as string, press as boolean) as boolean
'if press then
'    if key = "back" then
'        if not goBackInHistory() then
'            m.top.close = true
'        end if
'        return true
'    end if
'end if
'return false
'end function
'
'
