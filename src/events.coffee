options = [
  {id: "Downloader", contexts: ["link"], title: "Add to queue"},
  {id: "DownloaderFront", contexts: ["link"], title: "Add to front of queue"}
]
for option in options
  chrome.contextMenus.remove option.id
  chrome.contextMenus.create option

chrome.contextMenus.onClicked.addListener (info, tab) ->
  scope = angular.element("body").scope()
  scope.ChromeStorage.get("opendirectories.downloader").then (data) ->
    window.OpenDirectories.server = data.server
    window.OpenDirectories.port   = data.port
    if tab  
      urlParser = new window.Downloader.URLParser(info.linkUrl)
      model = urlParser.parse()

      if info.menuItemId == "Downloader"
        scope.Server.service.create(model)
        alert "Added to queue"
      else if info.menuItemId == "DownloaderFront"
        scope.Server.service.createInFront(model)
        alert "Added to front of queue"