AnchorTester = {}
AnchorTester.locationRegExp = new RegExp "//" + location.host + "($|/)"
AnchorTester.isCrossOrigin = (a) ->
  (a.href[0..3] == "http") and !AnchorTester.locationRegExp.test(a.href)

AnchorTester.hasInternalHrefContainingWord = (a, word) ->
  a.href.indexOf(word) != -1

AnchorTester.isClientSided = (a) ->
  (a.href[0..9] == "javascript") or
    AnchorTester.hasInternalHrefContainingWord a, "#"

strToFragment = (str) ->
  fragment = document.createDocumentFragment()
  tmp = document.createElement "div"
  tmp.innerHTML = str
  while tmp.firstChild
    fragment.appendChild tmp.firstChild
  fragment

eachLinkWithWord = (window, word, callback) ->
  process = (document) ->
    frame = document.querySelectorAll("frame")[1]
    if frame?
      content = frame.contentDocument.body.querySelector "#content"
    else
      content = document.querySelector "#content"
    anchors = content.getElementsByTagName "a"

    for a in anchors
      if a.href? and a.href != ""
        if !(AnchorTester.isCrossOrigin a) and !(AnchorTester.isClientSided a)
          if AnchorTester.hasInternalHrefContainingWord a, word
            callback a.href
          else
            request = new XMLHttpRequest()
            request.open "GET", a.href, true
            request.onerror = -> # ignore
            request.onload = ->
              process strToFragment @responseText

            request.send null

  process window.document

eachLinkWithWord window, "xid", (href) ->
  chrome.extension.sendMessage downloadable: href
