sub init()
    setScreenResolution()        
    m.backGroundImage = m.top.findNode("backGroundImage")
    m.backGroundImage.observeField("loadStatus","handleBackGroundImageLoading")
    
    m.bgImageMasking = m.top.findNode("bgImageMasking")
    m.bgImageMasking.width = m.screenWidth
    m.bgImageMasking.height = m.screenHeight
    m.bgImageMasking.loadWidth = m.screenWidth
    m.bgImageMasking.loadHeight = m.screenHeight
    m.bgImageMasking.uri = baseImageUrl()+"app_bg.png"
    
    m.rowList = m.top.findNode("rowList")
    m.rowList.translation = [m.screenWidth*0.10,m.screenWidth*0.60]
    m.rowList.ObserveField("rowItemFocused","handleFocusedContentNode")
    m.rowList.ObserveField("rowItemSelected","handleSelectedContentNode")
    initRowListProperties()
    m.top.ObserveField("homeListResponse","createHomeList")
    m.top.ObserveField("visible","onVisibleChange")
end sub

function onVisibleChange()
   if m.top.visible then
          m.rowList.content = invalid
          m.backGroundImage.uri=""
          m.rowList.setFocus(false)          
          showProgressDialog()
          FetchHomeList()
   end if
end function

function createHomeList(response as object)
    response = response.getData()
    if response <> invalid then
        ?"response=="response.Count()
        m.homeList = response
        createRowList(m.homeList)
    end if
end function

function initRowListProperties()
  rowHeight = m.screenHeight*0.31
  itemSpacing = m.screenWidth*0.01
  offsetX = m.screenWidth*0.0
  offsetY = m.screenHeight*0.005
  m.rowList.itemComponentName="ItemTemplateRowList"
  m.rowList.itemSize = [m.screenWidth*0.95,m.screenHeight*0.30]
  m.rowList.rowItemSize = [m.screenWidth*0.11,rowHeight]
  m.rowList.rowHeights = [rowHeight+50,rowHeight+50,rowHeight+50,rowHeight+50,rowHeight+50,rowHeight+50,rowHeight+50]
  m.rowList.itemSpacing = [itemSpacing,itemSpacing]
  m.rowList.rowItemSpacing = [itemSpacing,itemSpacing]
  m.rowList.rowFocusAnimationStyle = "floatingFocus"
  m.rowList.rowLabelFont = Hind_Bold(30)
  m.rowList.rowLabelOffset = [offsetX,offsetY]
  m.rowList.focusBitmapBlendColor = "#cd1024"
  m.rowList.rowCounterRightOffset=[m.screenWidth*0.10,m.screenWidth*0.10,m.screenWidth*0.10]
end function

function createRowList(dataArray)
    if dataArray <> invalid then
        rowSpacing = []
        rowLabelOffset = []
        itemSpacing = m.screenWidth*0.018
        dataContent  = CreateObject("roSGNode","ContentNode")
        for each rowData in dataArray
            rowContent = dataContent.createChild("ContentNode")
            if rowData.data.name <> invalid
                rowContent.title = rowData.data.name
            end if
            if rowData.data.contents <> invalid
                for each item in rowData.data.contents.data
                    itemContent = rowContent.createChild("RowListContentData")
                    if item <> invalid then
                        if item.images <> invalid OR item.images.artwork <> invalid then
                          itemContent.posterUrl = item.images.artwork
                        end if
                        if item.images <> invalid OR item.images.snapshot <> invalid then
                          m.backGroundImage.loadWidth = m.screenWidth
                          m.backGroundImage.loadHeight = m.screenHeight
                          m.backGroundImage.uri = item.images.snapshot
                        end if
                                              
                        if item.title <> invalid then
                          itemContent.title = item.title
                        end if
                    end if
                end for
            end if
            rowSpacing.push([itemSpacing*2.5])
            rowLabelOffset.push([offsetX,offsetY])
        end for
        m.rowList.rowSpacings =rowSpacing        
        m.rowList.translation = [m.screenWidth*0.05,m.screenHeight*0.40]        
        if m.global.deeplinking <> invalid then
            dismissProgressDialog()
            deeplink=m.global.deeplinking
            m.top.contentId=deeplink.id
            m.top.showPlayer=true
        else
            m.rowList.content = dataContent
            m.rowList.setFocus(true)
            dismissProgressDialog()
        end if
    else
        m.rowList.content = invalid
    end if

end function

function handleFocusedContentNode(focusEvent as object)
    focusRow = focusEvent.getData()
    row = focusRow[0]
    column = focusRow[1]
    focusedItem = m.homeList[row].data.contents.data[column]
    m.backGroundImage.uri = focusedItem.images.snapshot
end function

function handleSelectedContentNode(selectedEvent as object)
    selectedRow = selectedEvent.getData()
    row = selectedRow[0]
    column = selectedRow[1]
    focusedItem = m.homeList[row].data.contents.data[column]
    m.top.contentId=focusedItem.id
    m.top.showMovie=true
end function

Function OnKeyEvent(key, press) as Boolean
    result = false
      if press then
            if key = "back"
                result=false
            else if key = "OK"           
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