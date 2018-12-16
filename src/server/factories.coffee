app = angular.module "food.server.factories", []

app.factory "Server", [ "$http", "$q", ($http, $q) ->
  service:
    toString: -> "http://#{window.FoodLogger.server}:#{window.FoodLogger.port}"
    build: (path, params = []) ->
      url = "http://#{window.FoodLogger.server}:#{window.FoodLogger.port}#{path}"
      if params.length
        query = []
        for param in params
          for key, value of param
            query.push "#{key}=#{value}"
        url += "?#{query.join("&")}"

    search: (query) ->
      deferred = $q.defer()
      $http
        method: "GET"
        url: @build("/api/v1/food_items.json", [{query: query}])
        dataType: "jsonp"
      .then (response) -> 
        if response.data.success
          deferred.resolve response.data.data.food_items
        else
          deferred.reject response.data.message
      deferred.promise

    # # CRUD for downloads
    # get: (path) ->
    #   deferred = $q.defer()
    #   $http
    #     method: "GET"
    #     url: @build("/api/v1/downloads.json")
    #     dataType: "jsonp"
    #   .then (response) -> 
    #     data = for item in response.data
    #       item.visible    = false
    #       item.icon       = ICONS[item.status]
    #       item.hasPointer = (item.status != "initial" && item.status != "queued")
    #       item.canDelete  = (item.status != "started" && item.status != "queued")
    #       item.canCancel  = (item.status == "queued")
    #       item.canQueue   = (item.status == "initial" || item.status == "finished" || item.status == "error" || item.status == "cancelled")
    #       item
    #     deferred.resolve data
    #   deferred.promise
    # create: (model) ->
    #   deferred = $q.defer()
    #   data = {download: model}
    #   $http
    #     method: "POST"
    #     url: @build("/api/v1/downloads.json")
    #     data: data
    #   .then () ->
    #     deferred.resolve()
    #     return
    #   , (message) ->      
    #     deferred.reject(message.data.error)
    #     return
    #   deferred.promise
    # createInFront: (model) ->
    #   deferred = $q.defer()
    #   data = {download: model, front: true}
    #   $http
    #     method: "POST"
    #     url: @build("/api/v1/downloads.json")
    #     data: data
    #   .then () ->
    #     deferred.resolve()
    #     return
    #   , (message) ->      
    #     deferred.reject(message.data.error)
    #     return
    #   deferred.promise
    # delete: (download) ->
    #   return unless download.canDelete
    #   deferred = $q.defer()
    #   $http
    #     method: "DELETE"
    #     url: @build("/api/v1/downloads/#{download.id}")
    #     dataType: "jsonp"
    #   .then () -> deferred.resolve()
    #   deferred.promise
    # cancel: (download) ->
    #   return unless download.canCancel
    #   deferred = $q.defer()
    #   $http
    #     method: "PUT"
    #     url: @build("/api/v1/downloads/#{download.id}/cancel")
    #     dataType: "jsonp"
    #   .then () -> deferred.resolve()
    #   deferred.promise
    # queue: (download) ->
    #   return unless download.canQueue
    #   deferred = $q.defer()
    #   $http
    #     method: "PUT"
    #     url: @build("/api/v1/downloads/#{download.id}/queue")
    #     dataType: "jsonp"
    #   .then () -> deferred.resolve()
    #   deferred.promise
    # clear: ->
    #   deferred = $q.defer()
    #   $http
    #     method: "POST"
    #     url: @build("/api/v1/downloads/clear")
    #     dataType: "jsonp"
    #   .then () -> deferred.resolve()
    #   deferred.promise    
    # reorder: (downloads) ->
    #   deferred = $q.defer()
    #   data = {data: {}}
    #   for download in downloads
    #     data.data[download.id] = download.weight
    #   $http
    #     method: "POST"
    #     url: @build("/api/v1/downloads/reorder")
    #     data: data
    #   .then () ->
    #     deferred.resolve()
    #     return
    #   , (message) ->      
    #     deferred.reject(message.data.error)
    #     return
    #   deferred.promise
]