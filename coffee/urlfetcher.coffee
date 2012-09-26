xidUrls = []
for frame in window.document.querySelectorAll "frame"
  console.log frame.contentDocument.body
  for a in frame.contentDocument.body.querySelectorAll "a[href*=xid]"
    xidUrls.push a.href

chrome.extension.sendMessage urls: xidUrls
