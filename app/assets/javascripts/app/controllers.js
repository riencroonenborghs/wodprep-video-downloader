var app;

app = angular.module("downloader.controllers", []);

app.controller("AppController", [
  "$scope", "$rootScope", "$controller", "Server", "ICONS", "$mdDialog", function($scope, $rootScope, $controller, Server, ICONS, $mdDialog) {
    var icon, label;
    $scope.Server = Server;
    $controller("SettingsController", {
      $scope: $scope
    });
    $rootScope.$on("reload.app", function() {
      $controller("AuthController", {
        $scope: $scope
      });
      return $controller("DownloadsController", {
        $scope: $scope
      });
    });
    $scope.settings = function() {
      return $mdDialog.show({
        templateUrl: "settings/form.html",
        controller: "SettingsFormController",
        clickOutsideToClose: false
      }).then(function() {
        return $rootScope.$broadcast("reload.app");
      });
    };
    $scope.tabs = (function() {
      var results;
      results = [];
      for (label in ICONS) {
        icon = ICONS[label];
        results.push({
          title: label,
          icon: icon
        });
      }
      return results;
    })();
    return $scope.selectedIndex = 0;
  }
]);
