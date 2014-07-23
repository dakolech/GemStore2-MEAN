'use strict';

# Directives */

angular.module('myApp.directives', []).
	directive('appVersion',  (version) ->
		return (scope, elm, attrs) ->
			elm.text(version);
			return
	)
	.directive 'productTitle', ->
		restrict: 'A'
		templateUrl: 'partials/product-title'
		
	.directive 'productPanels',  ->
		restrict: 'A'
		templateUrl: 'partials/product-panels'
		controller: ->
			this.tab = 1

			this.selectTab = (setTab) ->
				this.tab = setTab

			this.isSelected = (checkTab) ->
				this.tab == checkTab
		controllerAs: 'panels'
		 
	.directive "productGallery", ->
		restrict: "A"
		templateUrl: "partials/product-gallery"
		controller:  ->
			this.current = 0;
			this.setCurrent = (imageNumber) ->
				this.current = imageNumber || 0
				return
			return
		controllerAs: "gallery"
