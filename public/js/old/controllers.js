'use strict';

/* Controllers */

angular.module('myApp.controllers', []).
  controller('AppCtrl', function ($scope, $http) {

    $http({
      method: 'GET',
      url: '/api/name'
    }).
    success(function (data, status, headers, config) {
      $scope.name = data.name;
    }).
    error(function (data, status, headers, config) {
      $scope.name = 'Error!';
    });

  }).
  controller('MyCtrl1', function ($scope) {
    // write Ctrl here

  }).
  controller('MyCtrl2', function ($scope) {
    // write Ctrl here

  }).
  controller('StoreController', [
    '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
      $scope.formData = {};
      $scope.formReview = {};
      $scope.formImage = {};
      $http.get('/api/products').success(function(data) {
        $scope.products = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
	}]);