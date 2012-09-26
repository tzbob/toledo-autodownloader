chrome.browserAction.onClicked.addListener (tab) ->
  chrome.tabs.executeScript null, file: "js/urlfetcher.js"

chrome.extension.onMessage.addListener (request) ->
  chrome.downloads.download
    url:request.downloadable
    saveAs: true
    , (id) ->
      if id? then console.log "finished", id
      else console.log chrome.extension.lastError
