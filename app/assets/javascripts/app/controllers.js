var app;

app = angular.module("wodprop-video-downloader.controllers", []);

app.controller("AppController", [
  "$scope",
  "$http",
  "$q",
  function($scope,
  $http,
  $q) {
    var getCurrentURL,
  getVideoID,
  getVideoStreams;
    $scope.busy = true;
    $scope.assets = [];
    getCurrentURL = function() {
      return chrome.tabs.query({
        active: true,
        currentWindow: true
      },
  function(tabs) {
        var activeTab;
        activeTab = tabs[0];
        return getVideoID(activeTab.url);
      });
    };
    getVideoID = function(url) {
      return $http.get(url).then(function(data) {
        var node,
  videoID;
        node = $(data.data).find("[data-wistia-id]")[0];
        videoID = node.dataset.wistiaId;
        return getVideoStreams(videoID);
      });
    };
    getVideoStreams = function(videoID) {
      var url;
      url = `http://fast.wistia.net/embed/iframe/${videoID}`;
      return $http.get(url).then(function(data) {
        var json,
  jsonString,
  regExp;
        regExp = new RegExp("W.iframeInit(.*);");
        jsonString = data.data.match(regExp)[1];
        jsonString = jsonString.substring(1,
  jsonString.length - 5);
        json = JSON.parse(jsonString);
        $scope.assets = json.assets;
        return $scope.busy = false;
      });
    };
    return getCurrentURL();
  }
]);
