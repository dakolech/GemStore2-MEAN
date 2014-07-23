angular.module('myApp', [
  'ngRoute',
  'myApp.controllers',
  'myApp.filters',
  'myApp.services',
  'myApp.directives'
]).
config( ($routeProvider, $locationProvider) ->
  $routeProvider.
    when('/view1', {
      templateUrl: 'partials/partial1',
      controller: 'MyCtrl1'
    }).
    when('/view2', {
      templateUrl: 'partials/partial2',
      controller: 'MyCtrl2'
    }).
    when('/product/:id', {
        templateUrl: 'partials/product',
        controller: 'StoreControllerOne'
    }).
    when('/products', {
        templateUrl: 'partials/products',
        controller: 'StoreController'
    });
  $locationProvider.html5Mode(true);
  return
);
