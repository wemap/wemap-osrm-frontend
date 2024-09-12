'use strict';

var L = require('leaflet');

var osmAttribution = '© <a href="https://www.openstreetmap.org/copyright/en">OpenStreetMap</a> contributors',
    waymarkedtrailsAttribution = '© <a href="http://waymarkedtrails.org">Sarah Hoffmann</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)';

var osm = L.tileLayer('//tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: osmAttribution,
  }),
  osm_de = L.tileLayer('//tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png', {
    attribution: '<a target="_blank" href="http://www.openstreetmap.org/">Karte hergestellt aus OpenStreetMap-Daten</a> | Lizenz: <a rel="license" target="_blank" href="http://opendatacommons.org/licenses/odbl/">Open Database License (ODbL)</a>'
  }),
  
  hiking = L.tileLayer('//tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png', {
    attribution: waymarkedtrailsAttribution,
  }),
  bike = L.tileLayer('//tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png', {
    attribution: waymarkedtrailsAttribution,
  }),
  small_components = L.tileLayer('https://tools.geofabrik.de/osmi/tiles/routing/{z}/{x}/{y}.png', {});

module.exports = {
  defaultState: {
    center: L.latLng(50, 12),
    zoom: 7,
    waypoints: [],
    language: 'en',
    alternative: 0,
    layer: osm_de,
    service: 1
  },
  services: [{
    label: 'Car',
    path: 'https://routing-osrm-car.getwemap.com/route/v1',
    debug: 'car',
  },
  {
    label: 'Bike (fastest)',
    path: 'https://routing-osrm-bicycle-fastest.getwemap.com/route/v1',
    debug: 'bike-fastest',
  },
  {
    label: 'Bike (safest)',
    path: 'https://routing-osrm-bicycle-safest.getwemap.com/route/v1',
    debug: 'bike-safest',
  },
  {
    label: 'Foot',
    path: 'https://routing-osrm-foot.getwemap.com/route/v1',
    debug: 'foot',
  },
  {
    label: 'Pmr',
    path: 'https://routing-osrm-pmr.getwemap.com/route/v1',
    debug: 'pmr',
  }],
  layer: [{
    'openstreetmap.de': osm_de,
    'openstreetmap.org': osm,
  }],
  overlay: {
    'hiking': hiking,
    'bike': bike,
    'Small Components': small_components
  },
  baselayer: {
    one: osm,
  }
};
