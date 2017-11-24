var app;

app = angular.module("downloader.settings.controllers", []);

app.controller("SettingsController", [
  "$scope", "ChromeStorage", "$timeout", "$mdDialog", "$auth", "$rootScope", function($scope, ChromeStorage, $timeout, $mdDialog, $auth, $rootScope) {
    var checkChromeStorage;
    checkChromeStorage = function() {
      ChromeStorage.get("opendirectories.downloader").then(function(data) {
        window.OpenDirectories.server = data.server;
        window.OpenDirectories.port = data.port;
        $auth.getConfig().apiUrl = "http://" + window.OpenDirectories.server + ":" + window.OpenDirectories.port;
        return $rootScope.$broadcast("reload.app");
      });
      return $timeout((function() {
        if (!window.OpenDirectories.server && !window.OpenDirectories.port) {
          return $mdDialog.show({
            templateUrl: "settings/form.html",
            controller: "SettingsFormController",
            clickOutsideToClose: false
          }).then(function() {
            return checkChromeStorage();
          });
        }
      }), 1500);
    };
    return checkChromeStorage();
  }
]);

app.controller("SettingsFormController", [
  "$scope", "$mdDialog", "ChromeStorage", function($scope, $mdDialog, ChromeStorage) {
    $scope.model = {
      server: window.OpenDirectories.server,
      port: window.OpenDirectories.port
    };
    $scope.save = function() {
      return ChromeStorage.set("opendirectories.downloader", $scope.model).then(function() {
        return $mdDialog.hide();
      });
    };
    return $scope.cancel = function() {
      return $mdDialog.hide();
    };
  }
]);
