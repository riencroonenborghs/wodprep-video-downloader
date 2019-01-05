app = angular.module "wodprop-video-downloader.controllers", []

app.controller "AppController", ["$scope", "$http", "$q",
($scope, $http, $q) ->

  $scope.busy = true
  $scope.assets = []
  getCurrentURL = ->
    chrome.tabs.query({active: true, currentWindow: true}, (tabs) ->
      activeTab = tabs[0]
      getVideoID activeTab.url      
    )

  getVideoID = (url) ->
    $http.get(url).then (data) ->
      node = $(data.data).find("[data-wistia-id]")[0]
      videoID = node.dataset.wistiaId
      getVideoStreams videoID

  getVideoStreams = (videoID) ->
    url = "http://fast.wistia.net/embed/iframe/#{videoID}"
    $http.get(url).then (data) ->
      regExp = new RegExp("W.iframeInit(.*);")
      jsonString = data.data.match(regExp)[1]
      jsonString = jsonString.substring(1, jsonString.length - 5)
      json = JSON.parse jsonString
      $scope.assets = json.assets
      $scope.busy = false

  $scope.download = (asset) ->
    chrome.downloads.download
      url: asset.url
      saveAs: true

  getCurrentURL()
]