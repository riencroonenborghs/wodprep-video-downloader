app = angular.module "downloader.directives", []

app.directive "onEnter", [->
  link: (scope, element, attrs) ->
    $(element).on "keypress", (event) ->
      if event.charCode == 13
        scope.$apply ()->
          scope.$eval attrs.onEnter, {"event": event}
        event.preventDefault()
]