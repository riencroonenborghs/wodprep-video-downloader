app = angular.module "downloader.controllers", []

app.controller "AppController", ["$scope", "$rootScope", "$controller", "Server", "ICONS", "$mdDialog", "ChromeStorage"
($scope, $rootScope, $controller, Server, ICONS, $mdDialog, ChromeStorage) ->
  # both are used for chrome events
  $scope.Server = Server 
  $scope.ChromeStorage = ChromeStorage
  
  $controller "SettingsController", $scope: $scope
  $rootScope.$on "reload.app", ->
    $controller "AuthController", $scope: $scope
    $controller "DownloadsController", $scope: $scope    

  $scope.settings = ->
    $mdDialog.show
      templateUrl: "settings/form.html",
      controller: "SettingsFormController",
      clickOutsideToClose: false
    .then ->
      $rootScope.$broadcast "reload.app"
  
  $scope.tabs = for label, icon of ICONS
    {title: label, icon: icon}
  $scope.selectedIndex = 0
]