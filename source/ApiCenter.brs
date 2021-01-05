function FetchHomeList()
    m.listId=["populares-en-taquilla","estrenos-para-toda-la-familia","estrenos-imprescindibles-en-taquilla","estrenos-espanoles","si-te-perdiste","especial-x-men","nuestras-preferidas-de-la-semana"]
    m.homeList=[]
    for each item in m.listId
        getHomeList(item)             
    end for              
end function
function getHomeList(item)
    urlPath = fnGetApiPathUrl("getList")
    querystring="/"+item+"?classification_id=5&device_identifier=web&locale=es&market_code=es"
    urlPath = urlPath+queryString
    requestHandlerObject = getServerObject()
    objectParam  = {
                "uri"           : urlPath,
                "requestType"   : "GET",
                "Content-Type"  : "application/json"
    }
    startTaskNode(requestHandlerObject,objectParam)
    requestHandlerObject.ObserveField("content","getListResponse")
end function

function getListResponse(response as object)
    taskNode = response.getRoSGNode()
    if taskNode <> invalid then
        responseCode  = taskNode.responseCode           
            m.homeJson = ParseJson(taskNode.content) 
            m.homeList.Push(m.homeJson)  
            if m.listId.Count()=m.homeList.Count()
               m.top.homeListResponse=m.homeList
            end if    
    else
        m.homeJson=""             
    end if

end function


function FetchMovieDetail(id)
    urlPath = fnGetApiPathUrl("getMovie")
    querystring="/"+id+"?classification_id=5&device_identifier=web&locale=es&market_code=es"
    urlPath = urlPath+queryString
    requestHandlerObject = getServerObject()
    ?"urlPath="urlPath
    objectParam  = {
                "uri"           : urlPath,
                "requestType"   : "GET"
    }
    startTaskNode(requestHandlerObject,objectParam)
    requestHandlerObject.ObserveField("content","getMovieResponse")
end function

function getMovieResponse(response as object)
    taskNode = response.getRoSGNode()
    if taskNode <> invalid then
        responseCode  = taskNode.responseCode           
            m.movieJson = ParseJson(taskNode.content)  
            m.top.movieResponse=m.movieJson       
    end if

end function


function fetchStream(id)
    urlPath = fnGetApiPathUrl("getStream")
    param={
          "audio_language":"SPA", 
          "audio_quality":"2.0", 
          "content_id":id,  
          "content_type":"movies", 
          "device_serial": "device_serial_1",
          "device_stream_video_quality":"FHD",
          "player":"web:PD-NONE",    
          "subtitle_language":"MIS",  
          "video_type":"trailer"  
          } 
    requestHandlerObject = getServerObject()
    objectParam  = {
                "uri"           : urlPath,
                "requestType"   : "POST",
                "Content-Type"  : "application/json",
                "param":param
    }
    startTaskNode(requestHandlerObject,objectParam)
    requestHandlerObject.ObserveField("content","getSteamDataResponse")
end function

function getSteamDataResponse(response as object)
    taskNode = response.getRoSGNode()
    if taskNode <> invalid then
        responseCode  = taskNode.responseCode           
            m.streamJson = ParseJson(taskNode.content)
            m.top.streamResponse=m.streamJson       
    end if

end function


