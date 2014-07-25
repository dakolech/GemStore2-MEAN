'use strict';

# Controllers 

angular.module('myApp.controllers', []).
	controller('AppCtrl',  ($scope, $http) ->
		$http.get('/api/categories')
			.success (data) ->
				$scope.categories = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
	).
	controller('MyCtrl1',  ($scope) ->
	# write Ctrl here

	).
	controller('MyCtrl2', ($scope) ->
	# write Ctrl here

	)
	.controller 'StoreControllerOne', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
		$http.get('/api/product/' + $routeParams.id)
	        .success (data) ->
				$scope.product = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
	]
	.controller 'StoreControllerCategory', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
		$scope.category = $routeParams.category
		
		$http.get('/api/products/' + $routeParams.category)
	        .success (data) ->
				$scope.products = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
	]
	.controller 'StoreController', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
		$scope.formData = {}
		$scope.formReview = {}
		$scope.formImage = {}
		$scope.formEdit = {}
		$scope.formCategory = {}
		$scope.editing = false
				
		$http.get('/api/products')
			.success (data) ->
				$scope.products = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return

		$http.get('/api/categories')
			.success (data) ->
				$scope.categories = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
				
				
		$scope.addProduct = ->
			console.log $scope.formData.category
			$http.post('/api/product', $scope.formData)
				.success (data) ->
					$scope.formData = {}  #clear the form so our user is ready to enter another 
					$scope.products = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return
			
		$scope.deleteProduct = (id) ->
			if (confirm("Are you sure to delete this product?"))
				$http.delete('/api/product/' + id)
					.success (data) ->
						$scope.products = data
						console.log(data)
						return
					.error (data) ->
						console.log('Error: ' + data)
						return
			return
		
		$scope.startEditProduct = (id) ->
			console.log id
			$scope.editing = true
			$http.get('/api/product/' + id)
		        .success (data) ->
					$scope.formEdit = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return

		$scope.editProduct = (product) ->			
			$http.post('/api/product/' + product._id, $scope.formEdit)
				.success (data) ->
					product.name = data.name
					product.price = data.price
					product.description = data.description
					product.category = data.category
					$scope.editing = false
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return
		
		$scope.addReview = (product) ->
			$scope.formReview.id = product._id
			localReview=$scope.formReview
			console.log(localReview)
			$http.post('/api/product/review', $scope.formReview)
				.success (data) ->
					product.reviews.push(localReview)
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			
			$scope.formReview = {}
			return


		$scope.imagesChanged = (elm) ->
			$scope.files = elm.files
			$scope.$apply();	
			console.log $scope.files
			return

		$scope.addImages = (id) ->
			for element, index in $scope.files
				fd = new FormData()

				fd.append("file", $scope.files[index])
				fd.append("id", id)
				console.log(id)
				console.log $scope.files[index]
				
				$http.post '/api/product/image', fd, {
					withCredentials: true,
					headers: {'Content-Type': undefined },
					transformRequest: angular.identity}
				.success (data) ->
					$scope.products = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
					
			$scope.formData = {}
			$scope.files = {}
			return 

		$scope.deleteImage = (id, name) ->
			if (confirm("Are you sure to delete this image?"))
				$scope.formImage.id = id
				$scope.formImage.name = name
				$scope.formImage.what = 'deleteImage'
				$http.post('/api/products/', $scope.formImage)
					.success (data) ->
						$scope.products = data
						console.log(data)
						return
					.error (data) ->
						console.log('Error: ' + data);
						return
				
				$scope.formImage = {}
			return

		$scope.addCategory = () ->
			console.log($scope.formCategory.name)
			$http.post('/api/category', $scope.formCategory)
				.success (data) ->
					$scope.categories = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			
			$scope.formReview = {}
			return

			
		return

	] 
	  
	.controller "PanelController", ['$scope', '$http', ($scope, $http) ->
		$scope.tab = 1

		$scope.selectTab = (setTab) ->
			$scope.tab = setTab;
			return

		$scope.isSelected = (checkTab) ->
			return $scope.tab == checkTab;
		return
	]
	  
	.controller "AdminEditPanelController", ['$scope', '$http', ($scope, $http) ->
		$scope.tab = 1

		$scope.selectTab = (setTab) ->
			$scope.tab = setTab
			return

		$scope.isSelected = (checkTab) ->
			return $scope.tab == checkTab
		return
	]
	  
	.controller('GalleryController',  ($scope, $http) ->
		$scope.current = 0

		$scope.setCurrent = (imageNumber) ->
			$scope.current = imageNumber || 0
			console.log("asd");
			return
		return
	)

