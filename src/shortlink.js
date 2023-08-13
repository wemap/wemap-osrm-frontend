var corslite = require('@mapbox/corslite');

module.exports = {
  osmli: function(url, callback) {
    var param = encodeURIComponent(url);
    corslite('//osm.li/get?url=' + param, function(err, resp) {
      if (resp) {
        var data = JSON.parse(resp.response);
        if (data && data.ShortURL) {
          callback(data.ShortURL);
        }
      }
      else {
        callback('');
      }
    }, true);
  }
};
