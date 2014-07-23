'use strict';

# Controllers 

angular.module('myApp.controllers', []).
	controller('AppCtrl',  ($scope, $http) ->
		$http.get('/api/name')
			.success (data) ->
				$scope.name = data.name
				console.log(data)
				return
			.error (data) ->
				$scope.name = 'Error!';
				console.log('Error: ' + data)
				return
	).
	controller('MyCtrl1',  ($scope) ->
	# write Ctrl here

	).
	controller('MyCtrl2', ($scope) ->
	# write Ctrl here

	).
	controller 'StoreController', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
		$scope.formData = {}
		$scope.formReview = {}
		$scope.formImage = {}
				
		$http.get('/api/products')
			.success (data) ->
				$scope.products = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
		return
	]