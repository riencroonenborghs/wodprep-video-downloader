var ReleasedTV, URLParser,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

window.Downloader || (window.Downloader = {});

window.Downloader.URLParser = URLParser = (function() {
  URLParser.registeredClasses = [];

  URLParser.register = function(klassName) {
    return this.registeredClasses.push(klassName);
  };

  function URLParser(url) {
    this.url = url;
  }

  URLParser.prototype.parse = function() {
    var i, len, model, modelUpdate, object, ref, registeredClass;
    model = {
      url: this.url
    };
    ref = this.constructor.registeredClasses;
    for (i = 0, len = ref.length; i < len; i++) {
      registeredClass = ref[i];
      object = new registeredClass(this.url);
      if (modelUpdate = object.matches()) {
        return $.extend(model, modelUpdate);
      }
    }
    return model;
  };

  URLParser.prototype.matches = function() {
    return null;
  };

  return URLParser;

})();

window.Downloader.ReleasedTV = ReleasedTV = (function(superClass) {
  extend(ReleasedTV, superClass);

  function ReleasedTV() {
    return ReleasedTV.__super__.constructor.apply(this, arguments);
  }

  ReleasedTV.register(ReleasedTV);

  ReleasedTV.prototype.matches = function() {
    if (this.url.match(/\:\/\/released.tv\/files\/(.*)/)) {
      return {
        http_username: "released",
        http_password: "released"
      };
    } else {
      return null;
    }
  };

  return ReleasedTV;

})(URLParser);
