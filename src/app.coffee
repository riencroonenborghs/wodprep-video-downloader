app = angular.module "wodprep-video-downloader", [
  "ngAria", 
  "ngAnimate", 
  "ngMaterial", 
  "wodprep-video-downloader.controllers"
]

app.config ($compileProvider) ->
  $compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/)

app.config ($mdThemingProvider) ->
  $mdThemingProvider.theme("default")
    .primaryPalette("green")
    .accentPalette("light-green")