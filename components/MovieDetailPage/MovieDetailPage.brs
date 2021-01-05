sub init()    
    setScreenResolution()   
    m.contentImg = m.top.findNode("contentImg")
    m.contentImg.width = m.screenWidth*0.16
    m.contentImg.height = m.screenHeight*0.40
    m.contentImg.loadWidth = m.screenWidth*0.16
    m.contentImg.loadHeight = m.screenHeight*0.40    
    m.contentImg.translation = [m.screenWidth*0.05,m.screenHeight*0.15]
    
    m.bgImg = m.top.findNode("bgImg")
    m.bgImg.width = m.screenWidth
    m.bgImg.height = m.screenHeight*0.67
    m.bgImg.loadWidth = m.screenWidth
    m.bgImg.loadHeight = m.screenHeight*0.67    
    m.bgImg.translation = [0,0]
    
    m.title = m.top.findNode("title")
    m.title.translation = [m.screenWidth*0.25,m.screenHeight*0.15]
    m.desc = m.top.findNode("desc")
    m.desc.width=m.screenWidth*0.39
    m.desBg = m.top.findNode("desBg")
    m.desBg.width=m.screenWidth*0.4
    m.desBg.height=m.screenWidth*0.20    
    m.desBg.translation = [m.screenWidth*0.25,m.screenHeight*0.22]
    m.desc.translation = [m.screenWidth*0.01,m.screenHeight*0.01]
    
    m.trailerButton = m.top.findNode("trailerButton")
    m.trailerButton.translation = [m.screenWidth*0.70,m.screenHeight*0.16]
    m.trailerText = m.top.findNode("trailerText")
    
    setUpFontSize()
    m.top.ObserveField("movieResponse","loadMovieData")
    m.top.ObserveField("visible","onVisibleChange")
end sub

function setUpFontSize()
    m.title.font= Hind_Bold(50)
    m.desc.font = Hind_Regular(25)
    m.trailerText.font = Hind_Regular(30)
end function

function onVisibleChange()
   if m.top.visible then     
        m.contentId=m.top.contentId
        'if m.movieData =invalid
           showProgressDialog()
           FetchMovieDetail(m.contentId)
        'else
        '   m.trailerButton.setFocus(true) 
        'end if
   end if
end function

function loadMovieData(response as object)
    response = response.getData()
    dismissProgressDialog()    
    if response <> invalid AND response.DoesExist("data") 
        m.movieData = response
        m.bgImg.visible=true
        m.contentImg.uri=m.movieData.data.images.artwork
        m.bgImg.uri=m.movieData.data.images.snapshot
        m.title.text=m.movieData.data.title
        m.desc.text=m.movieData.data.plot
        m.top.contentId=m.movieData.data.id
        m.trailerButton.setFocus(true) 
    end if
end function

Function OnKeyEvent(key, press) as Boolean
    result = false
      if press then
            if key = "back"
                m.top.showHome=true
                result=true
            else if key = "OK"    
                if m.trailerButton.hasFocus() 
                    m.top.showPlayer=true    
                end if
                result=true
            else if key = "up"            
                result=true
            else if key = "down"
                result=true
            else if key = "right"
                result=true
            else if key = "left"
                result=true
             end if
        end if
    return result
End Function