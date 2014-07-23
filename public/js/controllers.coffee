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

	)
	.controller 'StoreController', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
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
				
				
		$scope.createProduct = ->
			$scope.formData.what = 'create'
			$http.post('/api/products', $scope.formData)
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
				$http.delete('/api/products/' + id)
					.success (data) ->
						$scope.products = data
						console.log(data)
						return
					.error (data) ->
						console.log('Error: ' + data)
						return
			return
			
		$scope.startEditProduct = (id) ->
			$scope.formData.editing = true;
			$scope.formData.what = 'edit'
			$scope.formData.id = id
			$http.post('/api/products/', $scope.formData)
				.success (data) ->
					$scope.products = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return
			
		$scope.stopEditProduct = (id) ->
			$scope.formData.editing = false;
			$scope.formData.what = 'edit'
			$scope.formData.id = id		
			$http.post('/api/products/', $scope.formData)
				.success (data) ->
					$scope.products = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data);
					return
			return
			
		$scope.addReview = (product) ->
			$scope.formReview.id = product._id
			$scope.formReview.what = 'addReview'
			localReview=$scope.formReview
			console.log(localReview)
			$http.post('/api/products/', $scope.formReview)
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
			$scope.files=elm.files
			$scope.$apply();	
			return

		$scope.addImages = (id) ->
			for element, index in $scope.files
				console.log(id)
				fd = new FormData()

				fd.append("file", $scope.files[index])
				fd.append("id", id)
				console.log(id)
				
				$http.post '/api/images/', fd, {
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

