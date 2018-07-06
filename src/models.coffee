window.Downloader ||= {}

window.Downloader.URLParser = class URLParser
  @registeredClasses: []
  @register: (klassName) ->
    @registeredClasses.push klassName
  constructor: (@url) ->
  parse: ->
    model =
      url: @url
    for registeredClass in @constructor.registeredClasses
      object = new registeredClass(@url)
      if modelUpdate = object.matches()
        return $.extend model, modelUpdate
    model
  matches: -> null

window.Downloader.ReleasedTV = class ReleasedTV extends URLParser
  @register this
  matches: ->
    if @url.match(/\:\/\/released.tv\/files\/(.*)/)
      {http_username: "released", http_password: "released"}
    else
      null
