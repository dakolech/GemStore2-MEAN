'use strict';

# Filters 

angular.module('myApp.filters', []).
  filter('interpolate',  (version) ->
    return  (text) ->
      return String(text).replace(/\%VERSION\%/mg, version);
  );
