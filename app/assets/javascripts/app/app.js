var app;

app = angular.module("downloader", ["ng-token-auth", "ngAria", "ngAnimate", "ngMaterial", "ngMdIcons", "angular-sortable-view", "downloader.constants", "downloader.directives", "downloader.controllers", "downloader.server.factories", "downloader.auth.controllers", "downloader.downloads.controllers", "downloader.settings.controllers", "downloader.settings.services"]);

app.config(function($authProvider) {
  return $authProvider.configure({
    validateOnPageLoad: false
  });
});

app.config(function($compileProvider) {
  return $compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/);
});

window.OpenDirectories = {
  server: null,
  port: null
};

app.config(function($mdThemingProvider) {
  return $mdThemingProvider.theme("default").primaryPalette("blue").accentPalette("light-blue");
});
