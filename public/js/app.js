// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('myApp', ['ngRoute', 'myApp.controllers', 'myApp.filters', 'myApp.services', 'myApp.directives', 'textAngular', 'ui.bootstrap', 'ui.sortable']).config(function($routeProvider, $locationProvider) {
    $routeProvider.when('/:title', {
      templateUrl: 'partials/site',
      controller: 'SiteController'
    }).when('/product/show/:id/:name', {
      templateUrl: 'partials/product',
      controller: 'StoreControllerOne'
    }).when('/products/show/:category', {
      templateUrl: 'partials/productCategory',
      controller: 'StoreControllerCategory'
    }).when('/', {
      templateUrl: 'partials/main',
      controller: 'IndexController'
    }).when('/products/show', {
      templateUrl: 'partials/products',
      controller: 'ProductsController'
    });
    $locationProvider.html5Mode(true);
  });

}).call(this);
