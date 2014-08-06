// Generated by CoffeeScript 1.7.1
'use strict';
angular.module('myApp.controllers', []).controller('AppCtrl', function($scope, $http) {
  $http.get('/api/categories').success(function(data) {
    $scope.categories = data;
    console.log(data);
  }).error(function(data) {
    console.log('Error: ' + data);
  });
  return $http.get('/api/sites').success(function(data) {
    $scope.sites = data;
    console.log(data);
  }).error(function(data) {
    console.log('Error: ' + data);
  });
}).controller('IndexController', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    return $http.get('/api/site/index').success(function(data) {
      $scope.site = data;
      console.log($scope.site);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
  }
]).controller('SiteController', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    return $http.get('/api/site/' + $routeParams.title).success(function(data) {
      $scope.site = data;
      console.log($scope.site);
      console.log(data.added);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
  }
]).controller('StoreControllerOne', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formReview = {};
    $http.get('/api/product/' + $routeParams.id).success(function(data) {
      $scope.product = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addReview = function(id, product) {
      var localReview;
      console.log(id);
      localReview = $scope.formReview;
      $http.post('/api/product/review/' + id, $scope.formReview).success(function(data) {
        product.reviews.push(localReview);
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
  }
]).controller('StoreControllerCategory', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.category = $routeParams.category;
    $scope.formReview = {};
    $http.get('/api/products/' + $routeParams.category).success(function(data) {
      $scope.products = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addReview = function(id, product) {
      var localReview;
      console.log(id);
      localReview = $scope.formReview;
      $http.post('/api/product/review/' + id, $scope.formReview).success(function(data) {
        product.reviews.push(localReview);
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
  }
]).controller('ProductsController', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formReview = {};
    $http.get('/api/products').success(function(data) {
      $scope.products = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addReview = function(id, product) {
      var localReview;
      console.log(id);
      localReview = $scope.formReview;
      $http.post('/api/product/review/' + id, $scope.formReview).success(function(data) {
        product.reviews.push(localReview);
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
  }
]).controller('AdminControllerSites', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formSite = {};
    $http.get('/api/sites').success(function(data) {
      $scope.sites = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addSite = function() {
      console.log($scope.formSite.title);
      $http.post('/api/site', $scope.formSite).success(function(data) {
        $scope.sites = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
    $scope.deleteSite = function(id) {
      if (confirm("Are you sure to delete this site?")) {
        $http["delete"]('/api/site/' + id).success(function(data) {
          $scope.sites = data;
          console.log(data);
        }).error(function(data) {
          console.log('Error: ' + data);
        });
      }
    };
  }
]).controller('AdminControllerCategories', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formCategory = {};
    $http.get('/api/categories').success(function(data) {
      $scope.categories = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addCategory = function() {
      console.log($scope.formCategory.name);
      $http.post('/api/category', $scope.formCategory).success(function(data) {
        $scope.categories = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
  }
]).controller('AdminControllerProducts', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formData = {};
    $scope.formImage = {};
    $scope.formEdit = {};
    $http.get('/api/products').success(function(data) {
      $scope.products = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $http.get('/api/categories').success(function(data) {
      $scope.categories = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addProduct = function() {
      console.log($scope.formData.category);
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
      console.log(id);
      $scope.editing = true;
      $http.get('/api/product/' + id).success(function(data) {
        $scope.formEdit = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.editProduct = function(product) {
      $http.post('/api/product/' + product._id, $scope.formEdit).success(function(data) {
        product.name = data.name;
        product.price = data.price;
        product.description = data.description;
        product.category = data.category;
        $scope.editing = false;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.addReview = function(id, product) {
      var localReview;
      console.log(id);
      localReview = $scope.formReview;
      $http.post('/api/product/review/' + id, $scope.formReview).success(function(data) {
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
      console.log($scope.files);
    };
    $scope.addImages = function(id) {
      var element, fd, index, _i, _len, _ref;
      _ref = $scope.files;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        element = _ref[index];
        fd = new FormData();
        fd.append("file", $scope.files[index]);
        console.log($scope.files[index]);
        $http.post('/api/productImage/' + id, fd, {
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
        $scope.formImage.name = name;
        $http["delete"]('/api/productImage/' + id + '/' + name).success(function(data) {
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
]).controller("AdminPanelController", [
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
