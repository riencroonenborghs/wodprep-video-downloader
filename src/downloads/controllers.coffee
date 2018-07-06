app = angular.module "downloader.downloads.controllers", []

app.controller "NewDownloadController", ["$scope", "$rootScope", "$mdDialog", "Server", "$timeout",
($scope, $rootScope, $mdDialog, Server, $timeout) ->
  $scope.model = 
    url: ""
    http_username: ""
    http_password: ""
    file_filter: ""
    audio_only: false
    audio_format: "mp3"
    download_subs: false
    srt_subs: false
  $scope.forms = {}
  $scope.error = null
  $scope.resetAndCheck = ->
    $scope.error = null
    $scope.isYoutube = $scope.model.url.match(/youtu/) != null
  $scope.audioFormats = ["best", "aac", "flac", "mp3", "m4a", "opus", "vorbis", "wav"]
  $scope.save = () ->
    success = ->
      $rootScope.$broadcast "downloads.get"
      $mdDialog.hide(true)
    failure = (message) ->
      $scope.error = message
    Server.service.create($scope.model).then success, failure
  $scope.close = -> $mdDialog.hide(false)
  $scope.fileFilterPresetThrowAway = ""
  $scope.fileFilterPresets = [
    {value: "*720*", label: "720"},
    {value: "*1080*", label: "1080"}
  ]
  for counter in [1..10]
    $scope.fileFilterPresets.push {value: "*S0#{counter}*", label: "Season #{counter}"}
  $scope.setFileFilterPreset = -> 
    console.log $scope.fileFilterPresetThrowAway
    $scope.model.file_filter = $scope.fileFilterPresetThrowAway


  $timeout (->
    angular.element("#input-url").focus()
  ), 500
]

app.controller "DownloadsController", [ "$scope", "$rootScope", "$mdDialog", "Server", "$mdToast",
($scope, $rootScope, $mdDialog, Server, $mdToast) ->

  $scope.statuses = ["initial", "queued", "started", "finished", "error", "cancelled"]
  $scope.tabStatuses = ["queued", "started", "finished", "error", "cancelled"]

  showToast = (message) ->
    $mdToast.show($mdToast.simple().textContent(message).hideDelay(3000))

  $scope.downloads = false
  $rootScope.$on "downloads.get", () ->
    $scope.getDownloads()

  $scope.getDownloads = ->
    $scope.downloads = false
    Server.service.get("/api/v1/downloads.json").then (data) ->
      $scope.downloads = {}
      for download in data
        for status in $scope.statuses
          # $scope.downloadInfo = {id: download.id, percentage: "?", eta: "TBD"} if status == "started"
          $scope.downloads[status] ||= []
          $scope.downloads[status].push download if download.status == status
  
  $scope.newDownload = ($event) ->
    $mdDialog.show
      templateUrl: "downloads/new.html"
      controller: "NewDownloadController"
      clickOutsideToClose: false
    .then (added)->
      if added
        showToast "Download added."
        $scope.getDownloads()
      
  $scope.deleteDownload = (download, $event) ->
    confirm = $mdDialog.confirm()
      .title("Delete Download")
      .content("Are you sure you want to delete '#{download.url}'?")
      .ok("BE GONE WITH IT!")
      .cancel("No")
      .targetEvent($event)
    $mdDialog.show(confirm).then (() -> 
      Server.service.delete(download).then () -> 
        showToast "Download deleted."
        $scope.getDownloads())  
  $scope.cancelDownload = (download) -> 
    Server.service.cancel(download).then () -> 
      showToast "Download cancelled."
      $scope.getDownloads()
  $scope.queueDownload = (download) -> 
    Server.service.queue(download).then () -> 
      showToast "Download queued."
      $scope.getDownloads()
  $scope.clearDownloads = -> 
    Server.service.clear().then -> 
      showToast "All queues cleared."
      $scope.getDownloads()

  $scope.reorderDownloads = ->
    return unless $scope.selectedIndex == 0
    data = for download, index in $scope.downloads.queued
      download.weight = index
      download
    Server.service.reorder(data).then ()->
      showToast "Queues updated."
      $scope.getDownloads()
]