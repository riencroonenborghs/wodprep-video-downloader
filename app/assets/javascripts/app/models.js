var ReleasedTV, URLParser;

window.Downloader || (window.Downloader = {});

window.Downloader.URLParser = URLParser = (function() {
  class URLParser {
    static register(klassName) {
      return this.registeredClasses.push(klassName);
    }

    constructor(url) {
      this.url = url;
    }

    parse() {
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
    }

    matches() {
      return null;
    }

  };

  URLParser.registeredClasses = [];

  return URLParser;

}).call(this);

window.Downloader.ReleasedTV = ReleasedTV = (function() {
  class ReleasedTV extends URLParser {
    matches() {
      if (this.url.match(/\:\/\/released.tv\/files\/(.*)/)) {
        return {
          http_username: "released",
          http_password: "released"
        };
      } else {
        return null;
      }
    }

  };

  ReleasedTV.register(ReleasedTV);

  return ReleasedTV;

}).call(this);
