var app;

app = angular.module("wodprop-video-downloader", ["ngAria", "ngAnimate", "ngMaterial", "wodprop-video-downloader.controllers"]);

app.config(function($compileProvider) {
  return $compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/);
});

app.config(function($mdThemingProvider) {
  return $mdThemingProvider.theme("default").primaryPalette("green").accentPalette("light-green");
});
