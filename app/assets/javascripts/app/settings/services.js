var app;

app = angular.module("downloader.settings.services", []);

app.service("ChromeStorage", [
  "$q",
  function($q) {
    var service;
    service = {
      set: function(key,
  data) {
        var _data,
  deferred;
        _data = {};
        _data[key] = JSON.stringify(data);
        deferred = $q.defer();
        chrome.storage.local.set(_data,
  function() {
          return deferred.resolve();
        });
        return deferred.promise;
      },
      get: function(key) {
        var deferred;
        deferred = $q.defer();
        chrome.storage.local.get(key,
  function(data) {
          if (data[key]) {
            return deferred.resolve(JSON.parse(data[key]));
          } else {
            return deferred.resolve([]);
          }
        });
        return deferred.promise;
      },
      clear: function(key) {
        var deferred;
        deferred = $q.defer();
        chrome.storage.local.remove(key,
  function() {
          return deferred.resolve();
        });
        return deferred.promise;
      },
      add: function(key,
  item) {
        var deferred;
        deferred = $q.defer();
        this.get(key).then((data) => {
          data.push(item);
          return this.set(key,
  data).then(() => {
            return deferred.resolve();
          });
        });
        return deferred.promise;
      },
      remove: function(key,
  index) {
        var deferred;
        deferred = $q.defer();
        this.get(key).then((data) => {
          data.splice(index,
  1);
          return this.set(key,
  data).then(() => {
            return deferred.resolve();
          });
        });
        return deferred.promise;
      }
    };
    return service;
  }
]);
