var app;

app = angular.module("downloader.directives", []);

app.directive("onEnter", [
  function() {
    return {
      link: function(scope,
  element,
  attrs) {
        return $(element).on("keypress",
  function(event) {
          if (event.charCode === 13) {
            scope.$apply(function() {
              return scope.$eval(attrs.onEnter,
  {
                "event": event
              });
            });
            return event.preventDefault();
          }
        });
      }
    };
  }
]);
