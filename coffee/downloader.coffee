chrome.browserAction.onClicked.addListener (tab) ->
  chrome.tabs.executeScript null, file: "js/urlfetcher.js"

chrome.extension.onMessage.addListener (request) ->
  for url in request.urls
    chrome.downloads.download
      url:url
      , (id) ->
        if id? then console.log "finished", id
        else console.log chrome.extension.lastError
