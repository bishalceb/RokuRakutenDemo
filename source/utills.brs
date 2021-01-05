
function getBaseUrl()
		baseUrl ="https://gizmo.rakuten.tv/"
		return baseUrl
end function

function fnGetApiPathUrl(urlKey)
		configFile={
				"getList" : "v3/lists",
				"getMovie" : "v3/movies",
				"getStream":"v3/me/streamings?classification_id=5&device_identifier=web&locale=es&market_code=es"
		}
		if configFile.DoesExist(urlKey) then
				url = configFile[urlKey]
		else
				url = invalid
		end if
		return url
end function

function getSceneNode()
	nxt = m.top
	scene = nxt
	while nxt <> invalid
	  scene = nxt
	  nxt = scene.getParent()
	end while
	return scene
end function

function setScreenResolution()
		 resolutionObject =m.top.GetScene().currentDesignResolution
     m.screenWidth = resolutionObject.width
     m.screenHeight = resolutionObject.height
end function

function getServerObject()
		requestHandler = CreateObject("roSGNode","RequestHandler")
		return requestHandler
end function

function startTaskNode(requestHandlerObject,objectParam)
		if objectParam.uri <> invalid and len(objectParam.uri) > 0 then
				requestHandlerObject.SetField("uri", objectParam.uri)
		end if
		if objectParam.requestType <> invalid then
		 	if objectParam.DoesExist("requestType")  then
				requestHandlerObject.SetField("requestType", objectParam.requestType)
			end if
		end if

		if objectParam.contentType <> invalid then
				if objectParam.DoesExist("contentType")  then
						requestHandlerObject.SetField("contentType", objectParam.contentType)
				end if
		end if

		if objectParam.Authorization <> invalid then
				if objectParam.DoesExist("Authorization")  then
						? "objectParam "objectParam.Authorization
						requestHandlerObject.SetField("Authorization", FormatJson(objectParam.Authorization))
				end if
		end if

		if objectParam.param <> invalid then
				if objectParam.DoesExist("param")  then
						requestHandlerObject.SetField("param", FormatJson(objectParam.param))
				end if
		end if

	  requestHandlerObject.control="Run"
end function


sub showProgressDialog(msg=invalid)
  m.progressDialog = createObject("roSGNode", "ProgressDialog")
    m.progressDialog.backgroundUri="pkg:/locale/default/images/popup_0_bg.9.png"
    m.progressDialog.dividerUri="pkg:/locale/default/images/dailog-bo.jpg"
    w = m.screenWidth*0.01
    h = m.screenHeight*0.05
    m.progressDialog.translation = [w,h]
  if(msg = invalid)
        m.progressDialog.busySpinner.poster.width= 120
        m.progressDialog.busySpinner.poster.height= 120
        m.progressDialog.busySpinner.poster.blendColor = "#cd1024"
  else
        m.progressDialog.busySpinner.poster.width= 120
        m.progressDialog.busySpinner.poster.height= 120
        m.progressDialog.busySpinner.poster.blendColor = "#cd1024"
    m.progressDialog.title = msg
  end if
    m.progressDialog.setFocus(true)
  parentNode = getSceneNode()
  parentNode.dialog = m.progressDialog
end sub

sub dismissProgressDialog()
  if(m.progressDialog <> invalid)
    m.progressDialog.close = true
  end if
end sub

function getDeviceUniqueId()
		di = CreateObject("roDeviceInfo")
		return di.GetChannelClientId()
end function

function getChannelVersion()
    di = CreateObject("roAppInfo")
    return di.GetVersion()
end function

function baseImageUrl()
  return "pkg:/locale/default/images/"
end function


function showDialog(title,msg)
    m.ParentalControlSuccessPopup = createObject("roSGNode", "Dialog")
    m.ParentalControlSuccessPopup.title = title
    m.ParentalControlSuccessPopup.message = msg
    m.ParentalControlSuccessPopup.optionsDialog = false
    m.ParentalControlSuccessPopup.iconUri="pkg:/locale/default/images/popup_000.png"
    m.ParentalControlSuccessPopup.dividerUri="pkg:/locale/default/images/popup_000.png"
        m.ParentalControlSuccessPopup.backgroundUri="pkg:/locale/default/images/dialogBorder.9.png"
    m.ParentalControlSuccessPopup.buttons = ["OK"]
    m.ParentalControlSuccessPopup.observeField("buttonSelected", "onParentalControlSuccessButtonSelected")
    m.sceneNode = getSceneNode()
    m.sceneNode.dialog = m.ParentalControlSuccessPopup
end function

function onParentalControlSuccessButtonSelected()
    selectedIndex = m.ParentalControlSuccessPopup.buttonSelected
    m.ParentalControlSuccessPopup.close = true
end function


function showExitConfirmationPopup(title,msg)
    m.exitDialog = createObject("roSGNode", "Dialog")
    m.exitDialog.title = title
		m.exitDialog.message = msg

    m.exitDialog.optionsDialog = false
    m.exitDialog.iconUri="pkg:/locale/default/images/popup_000.png"
    m.exitDialog.dividerUri="pkg:/locale/default/images/popup_000.png"
		m.exitDialog.backgroundUri="pkg:/locale/default/images/dialogBorder.9.png"
    m.exitDialog.buttons = ["Yes", "No"]
    m.exitDialog.observeField("buttonSelected", "onExitDialogbuttonSelected")
    m.sceneNode = getSceneNode()
    m.sceneNode.dialog = m.exitDialog
end function

function onExitDialogbuttonSelected()
    selectedIndex = m.exitDialog.buttonSelected
    m.exitDialog.close = true
    if(selectedIndex = 0)
        m.top.isExitApp = true
    end if
end function

