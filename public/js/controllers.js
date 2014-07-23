// Generated by CoffeeScript 1.7.1
'use strict';
angular.module('myApp.controllers', []).controller('AppCtrl', function($scope, $http) {
  return $http.get('/api/name').success(function(data) {
    $scope.name = data.name;
    console.log(data);
  }).error(function(data) {
    $scope.name = 'Error!';
    console.log('Error: ' + data);
  });
}).controller('MyCtrl1', function($scope) {}).controller('MyCtrl2', function($scope) {}).controller('StoreController', [
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
    $scope.createProduct = function() {
      $http.post('/api/product', $scope.formData).success(function(data) {
        $scope.formData = {};
        $scope.products = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.deleteProduct = function(id) {
      if (confirm("Are you sure to delete this product?")) {
        $http["delete"]('/api/product/' + id).success(function(data) {
          $scope.products = data;
          console.log(data);
        }).error(function(data) {
          console.log('Error: ' + data);
        });
      }
    };
    $scope.startEditProduct = function(id) {
      $scope.formData.editing = true;
      $scope.formData.what = 'edit';
      $scope.formData.id = id;
      $http.post('/api/products/', $scope.formData).success(function(data) {
        $scope.products = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.stopEditProduct = function(id) {
      $scope.formData.editing = false;
      $scope.formData.what = 'edit';
      $scope.formData.id = id;
      $http.post('/api/products/', $scope.formData).success(function(data) {
        $scope.products = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.addReview = function(product) {
      var localReview;
      $scope.formReview.id = product._id;
      $scope.formReview.what = 'addReview';
      localReview = $scope.formReview;
      console.log(localReview);
      $http.post('/api/products/', $scope.formReview).success(function(data) {
        product.reviews.push(localReview);
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
    $scope.imagesChanged = function(elm) {
      $scope.files = elm.files;
      $scope.$apply();
    };
    $scope.addImages = function(id) {
      var element, fd, index, _i, _len, _ref;
      _ref = $scope.files;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        element = _ref[index];
        console.log(id);
        fd = new FormData();
        fd.append("file", $scope.files[index]);
        fd.append("id", id);
        console.log(id);
        $http.post('/api/images/', fd, {
          withCredentials: true,
          headers: {
            'Content-Type': void 0
          },
          transformRequest: angular.identity
        }).success(function(data) {
          $scope.products = data;
          console.log(data);
        }).error(function(data) {
          console.log('Error: ' + data);
        });
      }
      $scope.formData = {};
      $scope.files = {};
    };
    $scope.deleteImage = function(id, name) {
      if (confirm("Are you sure to delete this image?")) {
        $scope.formImage.id = id;
        $scope.formImage.name = name;
        $scope.formImage.what = 'deleteImage';
        $http.post('/api/products/', $scope.formImage).success(function(data) {
          $scope.products = data;
          console.log(data);
        }).error(function(data) {
          console.log('Error: ' + data);
        });
        $scope.formImage = {};
      }
    };
  }
]).controller("PanelController", [
  '$scope', '$http', function($scope, $http) {
    $scope.tab = 1;
    $scope.selectTab = function(setTab) {
      $scope.tab = setTab;
    };
    $scope.isSelected = function(checkTab) {
      return $scope.tab === checkTab;
    };
  }
]).controller("AdminEditPanelController", [
  '$scope', '$http', function($scope, $http) {
    $scope.tab = 1;
    $scope.selectTab = function(setTab) {
      $scope.tab = setTab;
    };
    $scope.isSelected = function(checkTab) {
      return $scope.tab === checkTab;
    };
  }
]).controller('GalleryController', function($scope, $http) {
  $scope.current = 0;
  $scope.setCurrent = function(imageNumber) {
    $scope.current = imageNumber || 0;
    console.log("asd");
  };
});
