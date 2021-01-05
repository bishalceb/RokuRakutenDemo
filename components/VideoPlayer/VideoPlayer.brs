sub init()
   setScreenResolution() 
   m.videoPlayer =   m.top.findNode("VideoPlayer")
   m.top.ObserveField("visible","onVisibleChange")
   m.top.ObserveField("streamResponse","getStream")
end sub


Sub onVisibleChange(event as object)
    isVisible = event.getdata()
    m.videoPlayer.visible=true
    m.videoPlayer.setFocus(true)
    if m.top.visible then       
        showProgressDialog()
        m.contentId=m.top.contentId
        fetchStream(m.contentId)
     end if
end Sub

function getStream(response as object)
    response = response.getData()
    dismissProgressDialog()    
    if response <> invalid then
        m.streamData = response
        loadStreamUrl()
    end if
end function


Sub OnVideoPlayerStateChange()
  print "Playerpage.brs - [OnVideoPlayerStateChange]"
  if m.videoPlayer.state = "buffering"
      ? "video is Buffering please Wait"
  else if m.videoPlayer.state = "error"
    m.videoPlayer.visible = false
    m.videoPlayer.setFocus(true)
  else if m.videoPlayer.state = "playing"
    m.videoPlayer.visible = true
    m.videoPlayer.setFocus(true)
  else if m.videoPlayer.state = "finished"
    finsihPlayer()
  end if
End Sub

function loadStreamUrl()
    if m.streamData<> invalid AND m.streamData.DoesExist("data") AND m.streamData.data.stream_infos[0].url <> invalid
         ContentNode = CreateObject("roSGNode", "ContentNode")
         ContentNode.url=m.streamData.data.stream_infos[0].url
         ContentNode.streamFormat ="mp4"
     end if
     
     m.videoPlayer.content = ContentNode
     m.videoPlayer.visible = true
     m.videoPlayer.setFocus(true)
     m.videoPlayer.control = "play"
     m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
     m.videoPlayer.observeField("position","onPlayerPosition")
     dismissProgressDialog()
end function


function finsihPlayer()
      m.videoPlayer.control = "stop"
      m.videoPlayer.visible = false
      m.videoPlayer.setFocus(false)
      m.top.showMovie=true
end function


Function OnkeyEvent(key, press) as Boolean
    print "in Player.xml onKeyEvent ";key;" "; press
    result = false
    if press
       if key = "back"
           finsihPlayer()          
           return true
       else if key="OK"
           return true
       else if key="up"
           return true
       else if key="down"
           return true
       else if key="left"
           return true
       else if key="right"
           return true
       end if
    end if

End Function
