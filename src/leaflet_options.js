'use strict';

var L = require('leaflet');

var standard = L.tileLayer('//{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png', {
    attribution: 'Map data © OpenStreetMap contributors under <a ref="http://www.openstreetmap.org/copyright">ODbL</a>'
  }),
  hiking = L.tileLayer('//tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png', {}),
  bike = L.tileLayer('//tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png', {})

module.exports = {
  defaultState: {
    center: L.latLng(50, 12),
    zoom: 7,
    waypoints: [],
    language: 'en',
    alternative: 0,
    layer: standard,
    service: 1
  },
  services: [{
    label: 'Car',
    path: '/routed-car/route/v1',
    debug: 'car',
    fixspeed: 0
  },
  {
    label: 'Bike',
    path: '/routed-bike/route/v1',
    debug: 'bike',
    fixspeed: 18
  },
  {
    label: 'Foot',
    path: '/routed-foot/route/v1',
    debug: 'foot',
    fixspeed: 4.5
  }],
  layer: [{
    'standard': standard,
  }],
  overlay: {
    'hiking': hiking,
    'bike': bike,
  },
  baselayer: {
    one: standard,
  }
};
