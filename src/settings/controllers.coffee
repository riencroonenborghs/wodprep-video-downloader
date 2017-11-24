app = angular.module "downloader.settings.controllers", []

app.controller "SettingsController", ["$scope", "ChromeStorage", "$timeout", "$mdDialog", "$auth", "$rootScope",
($scope, ChromeStorage, $timeout, $mdDialog, $auth, $rootScope) ->

  checkChromeStorage = ->
    ChromeStorage.get("opendirectories.downloader").then (data)->
      window.OpenDirectories.server = data.server
      window.OpenDirectories.port   = data.port
      $auth.getConfig().apiUrl = "http://#{window.OpenDirectories.server}:#{window.OpenDirectories.port}"
      $rootScope.$broadcast "reload.app"
    $timeout (->
      if !window.OpenDirectories.server && !window.OpenDirectories.port
        $mdDialog.show
          templateUrl: "settings/form.html",
          controller: "SettingsFormController",
          clickOutsideToClose: false
        .then ->
          checkChromeStorage()
    ), 1500

  checkChromeStorage()
]

app.controller "SettingsFormController", ["$scope", "$mdDialog", "ChromeStorage", ($scope, $mdDialog, ChromeStorage)->
  $scope.model =
    server: window.OpenDirectories.server
    port: window.OpenDirectories.port
  $scope.save = ->
    ChromeStorage.set("opendirectories.downloader", $scope.model).then ->
      $mdDialog.hide()
  $scope.cancel = -> $mdDialog.hide()
]