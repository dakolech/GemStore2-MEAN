'use strict';

# Controllers 

angular.module('myApp.controllers', []).
	controller 'AppCtrl',  ['$scope', '$http', 'Page', 'Categories', 'Settings', ($scope, $http, Page, Categories, Settings) ->

		$scope.Page = Page;

		###
		$http.get('/api/categories')
			.success (data) ->
				$scope.categories = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
		###
		Settings.async().then((d)->
			$scope.settings = d
			Page.setTitle2(' - '+$scope.settings.title)
			Page.setDescription($scope.settings.description)
		)

		Categories.async().then((d)->
			$scope.categories = d
		)

		$http.get('/api/sites')
			.success (data) ->
				$scope.sites = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
	] 
	.controller 'IndexController', ['$scope', '$http', '$routeParams', 'Page', 'Settings', ($scope, $http, $routeParams, Page, Settings) ->

		Settings.async().then((d)->
			$scope.settings = d
			Page.setTitle($scope.settings.indexTitle)
		)

		$http.get('/api/site/index')
	        .success (data) ->
				$scope.site = data
				console.log $scope.site
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
	]	
	.controller 'SiteController', ['$scope', '$http', '$routeParams', 'Page', ($scope, $http, $routeParams, Page) ->
		$http.get('/api/site/' + $routeParams.title)
	        .success (data) ->
				$scope.site = data
				Page.setTitle($scope.site.title)
				console.log $scope.site
				console.log(data.added)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
	]
	.controller 'StoreControllerOne', ['$scope', '$http', '$routeParams', 'Page', ($scope, $http, $routeParams, Page) ->
		$scope.formReview = {}

		$http.get('/api/product/' + $routeParams.id)
	        .success (data) ->
				$scope.product = data
				Page.setTitle($scope.product.name)
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return

		$scope.addReview = (id, product) ->
			console.log(id)
			localReview = $scope.formReview
			$http.post('/api/product/review/'+id, $scope.formReview)
				.success (data) ->
					product.reviews.push(localReview)
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			
			$scope.formReview = {}
			return

		return				
	]
	.controller 'StoreControllerCategory', ['$scope', '$http', '$routeParams', 'Page', ($scope, $http, $routeParams, Page) ->
		$scope.category = $routeParams.category
		$scope.formReview = {}
		
		$http.get('/api/products/' + $routeParams.category)
	        .success (data) ->
				$scope.products = data
				Page.setTitle($routeParams.category)
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return

		$scope.addReview = (id, product) ->
			console.log(id)
			localReview = $scope.formReview
			$http.post('/api/product/review/'+id, $scope.formReview)
				.success (data) ->
					product.reviews.push(localReview)
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			
			$scope.formReview = {}
			return

		return	
	]
	.controller 'ProductsController', ['$scope', '$http', '$routeParams', 'Page', 'Settings', ($scope, $http, $routeParams, Page, Settings) ->
		$scope.formReview = {}

		Settings.async().then((d)->
			$scope.settings = d
			Page.setTitle($scope.settings.productsTitle)
		)
				
		$http.get('/api/products')
			.success (data) ->
				$scope.products = data
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return

		$scope.addReview = (id, product) ->
			console.log(id)
			localReview = $scope.formReview
			$http.post('/api/product/review/'+id, $scope.formReview)
				.success (data) ->
					product.reviews.push(localReview)
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			
			$scope.formReview = {}
			return


		
		return
	]

	.controller 'AdminControllerSettings', ['$scope', '$http', '$routeParams', 'Page', 'Settings', ($scope, $http, $routeParams, Page, Settings) ->
		$scope.formSettings = {}

		Settings.async().then((d)->
			$scope.formSettings = d
			Page.setTitle('Admin Panel')
			Page.setTitle2(' - '+$scope.formSettings.title)
		)	

		###
		$http.get('/api/settings')
	        .success (data) ->
				$scope.formSettings = data
				console.log $scope.formSettings
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
		###
		$scope.editSettings = ->
			console.log $scope.formSettings
			$http.post('/api/settings', $scope.formSettings)
				.success (data) ->
					$scope.formSettings = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return



		$scope.addSettings = ->
			$scope.formSettings.title = 'Gemstore.com'
			$scope.formSettings.footer = 'Footer'
			$scope.formSettings.indexTitle = 'Main Page'
			$scope.formSettings.description = 'Description of Gemstore.com'
			$http.post('/api/asettings', $scope.formSettings)
				.success (data) ->
					$scope.settings = data
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return

	] 
	.controller 'AdminControllerSites', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
		$scope.formSite = {}
		$scope.isCollapsedAdd = true
		$scope.formEditSite = {}
		$scope.isCollapsedEdit = []
		$scope.isCollapsedShow = []
		$scope.sitesOrder = []

		$http.get('/api/sites')
			.success (data) ->
				$scope.sites = data
				for i in [0..$scope.sites.length-1] by 1
					$scope.isCollapsedEdit[i] = true
					$scope.isCollapsedShow[i] = true
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return
				
		$scope.addSite = () ->
			console.log($scope.formSite.title)
			$http.post('/api/site', $scope.formSite)
				.success (data) ->
					$scope.sites = data
					for i in [0..$scope.sites.length-1] by 1
						$scope.isCollapsedEdit[i] = true
						$scope.isCollapsedShow[i] = true
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			
			$scope.formReview = {}
			return

		$scope.startEditSite = (title, index) ->
			console.log title
			$http.get('/api/site/'+title)
				.success (data) ->
					$scope.formEditSite = data
					for i in [0..$scope.sites.length-1] by 1
						$scope.isCollapsedEdit[i] = true
					$scope.isCollapsedEdit[index] = !$scope.isCollapsedEdit[index]
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return

		$scope.editSite = (site) ->
			console.log $scope.formEditSite.title+site._id

			$http.post('/api/site/' + site._id, $scope.formEditSite)
				.success (data) ->
					site.title = data.title
					site.content = data.content
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return

		$scope.deleteSite = (id) ->
			if (confirm("Are you sure to delete this site?"))
				$http.delete('/api/site/' + id)
					.success (data) ->
						$scope.sites = data
						for i in [0..$scope.sites.length-1] by 1
							$scope.isCollapsedEdit[i] = true
							$scope.isCollapsedShow[i] = true
						console.log(data)
						return
					.error (data) ->
						console.log('Error: ' + data)
						return
			return

		$scope.sortableOptions = {
			stop: (e, ui) ->
				for i in [0..$scope.sites.length-1] by 1
					$scope.sitesOrder[i]=$scope.sites[i]._id
					#console.log $scope.sites[i] 
					#$scope.sites[i].place = i
					#console.log $scope.sites[i].place
				console.log $scope.sitesOrder
				

			}

		$scope.saveOrder = () ->
			$http.post('/api/sites/order', $scope.sitesOrder)
			
			$http.get('/api/sites')
				.success (data) ->
					$scope.sites = data
					for i in [0..$scope.sites.length-1] by 1
						$scope.isCollapsedEdit[i] = true
						$scope.isCollapsedShow[i] = true
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return					
			return
	
		return
	] 
	.controller 'AdminControllerCategories', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
		$scope.formCategory = {}
		$scope.isCollapsedAdd = true
		$scope.formEditCategory = {}
		$scope.isCollapsedEdit = []
		$scope.isCollapsedShow = []

		$http.get('/api/categories')
			.success (data) ->
				$scope.categories = data
				for i in [0..$scope.categories.length-1] by 1
					$scope.isCollapsedEdit[i] = true
					$scope.isCollapsedShow[i] = true
				console.log(data)
				return
			.error (data) ->
				console.log('Error: ' + data)
				return	
				
		$scope.addCategory = () ->
			console.log($scope.formCategory.name)
			$http.post('/api/category', $scope.formCategory)
				.success (data) ->
					$scope.categories = data
					for i in [0..$scope.categories.length-1] by 1
							$scope.isCollapsedEdit[i] = true
							$scope.isCollapsedShow[i] = true					
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			
			$scope.formReview = {}
			return	

		$scope.startEditCategory = (id, index) ->
			$http.get('/api/category/'+id)
				.success (data) ->
					$scope.formEditCategory = data
					for i in [0..$scope.categories.length-1] by 1
						$scope.isCollapsedEdit[i] = true
					$scope.isCollapsedEdit[index] = !$scope.isCollapsedEdit[index]
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return

		$scope.editCategory = (category) ->
			console.log $scope.formEditCategory.name+category._id

			$http.post('/api/category/' + category._id+'/'+category.name, $scope.formEditCategory)
				.success (data) ->
					category.name = data.name
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return	

		$scope.showProducts = (name, index) ->
			$http.get('/api/products/'+name)
				.success (data) ->
					$scope.products = data
					for i in [0..$scope.categories.length-1] by 1
						$scope.isCollapsedShow[i] = true
					$scope.isCollapsedShow[index] = !$scope.isCollapsedShow[index]
					console.log(data)
					return
				.error (data) ->
					console.log('Error: ' + data)
					return
			return

		$scope.deleteCategory = (category) ->
			if (confirm("Are you sure to delete this category with all products?"))
				$http.delete('/api/category/' + category._id+'/'+category.name)
					.success (data) ->
						$scope.categories = data
						for i in [0..$scope.categories.length-1] by 1
							$scope.isCollapsedEdit[i] = true
							$scope.isCollapsedShow[i] = true
						console.log(data)
						return
					.error (data) ->
						console.log('Error: ' + data)
						return
			return
		
		return
	] 
	.controller 'AdminControllerProducts', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
		$scope.formData = {}
		$scope.formImage = {}
		$scope.formEdit = {}
		$scope.isCollapsedAdd = true
		$scope.isCollapsedEdit = []
		$scope.isCollapsedShow = []

		$http.get('/api/products')
			.success (data) ->
				$scope.products = data
				for i in [0..$scope.products.length-1] by 1
					$scope.isCollapsedEdit[i] = true
					$scope.isCollapsedShow[i] = true
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

		$scope.refreshCategories = () ->
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
					for i in [0..$scope.products.length-1] by 1
						$scope.isCollapsedEdit[i] = true
						$scope.isCollapsedShow[i] = true
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
						for i in [0..$scope.products.length-1] by 1
							$scope.isCollapsedEdit[i] = true
							$scope.isCollapsedShow[i] = true
						console.log(data)
						return
					.error (data) ->
						console.log('Error: ' + data)
						return
			return

		$scope.startEditProduct = (id, index) ->
			console.log id
			$scope.editing = true
			$http.get('/api/product/' + id)
		        .success (data) ->
					$scope.formEdit = data
					for i in [0..$scope.products.length-1] by 1
						$scope.isCollapsedEdit[i] = true
					$scope.isCollapsedEdit[index] = !$scope.isCollapsedEdit[index]
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
		
		$scope.addReview = (id, product) ->
			console.log(id)
			localReview = $scope.formReview
			$http.post('/api/product/review/'+id, $scope.formReview)
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
				console.log $scope.files[index]
				
				$http.post '/api/productImage/'+id, fd, {
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
				$scope.formImage.name = name
				$http.delete('/api/productImage/'+id+'/'+name)
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

	.controller "AdminPanelController", ['$scope', '$http', ($scope, $http) ->
		$scope.tab = 1

		$scope.selectTab = (setTab) ->
			$scope.tab = setTab
			return

		$scope.isSelected = (checkTab) ->
			return $scope.tab == checkTab
		return
	]
	  
	.controller 'GalleryController', ['$scope', '$http', ($scope, $http) ->
		$scope.current = 0

		$scope.marginValue = 0
		$scope.marginLeft = '0px'

		$scope.left = ->
			$scope.marginValue += 104
			$scope.marginLeft = $scope.marginValue + 'px'
			return

		$scope.right = ->
			$scope.marginValue -= 104
			$scope.marginLeft = $scope.marginValue + 'px'
			return

		$scope.setCurrent = (imageNumber) ->
			$scope.current = imageNumber || 0
			console.log("asd");
			return
		return
	]

