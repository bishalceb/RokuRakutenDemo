sub init()
    setScreenResolution()         
    m.menuBg = m.top.findNode("menuBg")
    m.menuBg.translation = [0,0]
    m.menuBg.width=m.screenWidth
    m.menuBg.height=m.screenHeight*0.1
    m.logo = m.top.findNode("logo")
    m.logo.translation = [m.screenWidth*0.05,m.screenWidth*0.02]
    m.logo.uri=baseImageUrl()+"logo.png"
end sub