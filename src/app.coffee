app = angular.module "downloader", [
  "ng-token-auth",
  "ngAria", 
  "ngAnimate", 
  "ngMaterial", 
  "ngMdIcons",
  "angular-sortable-view",
  "downloader.constants",
  "downloader.directives",
  "downloader.controllers",
  "downloader.server.factories",
  "downloader.auth.controllers",
  "downloader.downloads.controllers",
  "downloader.settings.controllers",
  "downloader.settings.services"
]

app.config ($authProvider ) ->
  $authProvider.configure
    validateOnPageLoad: false

window.OpenDirectories =
  server: null
  port: null

app.config ($mdThemingProvider) ->
  $mdThemingProvider.theme("default")
    .primaryPalette("blue")
    .accentPalette("light-blue")