// Generated by CoffeeScript 1.7.1
'use strict';
angular.module('myApp.controllers', []).controller('AppCtrl', [
  '$rootScope', '$scope', '$http', 'Page', 'User', 'Categories', 'Settings', function($rootScope, $scope, $http, Page, User, Categories, Settings) {
    $scope.Page = Page;
    $rootScope.hideMenu = false;
    $scope.User = [];
    $scope.$watch((function() {
      return User.getName();
    }), function(value) {
      $scope.User.name = value;
    });
    $http.get('/api/userCookie').success(function(data) {
      console.log(data.length);
      if (data.length === 4) {
        $scope.User.name = false;
      } else {
        User.setName(data.local.email);
      }
      console.log(data.local);
    }).error(function(data) {
      console.log('Error: ' + data);
    });

    /*
    		$http.get('/api/categories')
    			.success (data) ->
    				$scope.categories = data
    				console.log(data)
    				return
    			.error (data) ->
    				console.log('Error: ' + data)
    				return
     */
    Settings.async().then(function(d) {
      $scope.settings = d;
      Page.setTitle2(' - ' + $scope.settings.title);
      return Page.setDescription($scope.settings.description);
    });
    Categories.async().then(function(d) {
      return $scope.categories = d;
    });
    $http.get('/api/sites').success(function(data) {
      $scope.sites = data;
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    return $scope.logout = function() {
      User.setName(false);
      $http.get('/logout').success(function(data) {
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
  }
]).controller('IndexController', [
  '$scope', '$http', '$routeParams', 'Page', 'Settings', function($scope, $http, $routeParams, Page, Settings) {
    Settings.async().then(function(d) {
      $scope.settings = d;
      return Page.setTitle($scope.settings.indexTitle);
    });
    return $http.get('/api/site/index').success(function(data) {
      $scope.site = data;
      console.log($scope.site);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
  }
]).controller('SiteController', [
  '$scope', '$http', '$routeParams', 'Page', function($scope, $http, $routeParams, Page) {
    return $http.get('/api/site/' + $routeParams.title).success(function(data) {
      $scope.site = data;
      Page.setTitle($scope.site.title);
      console.log($scope.site);
      console.log(data.added);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
  }
]).controller('StoreControllerOne', [
  '$scope', '$http', '$routeParams', 'Page', function($scope, $http, $routeParams, Page) {
    $scope.formReview = {};
    $http.get('/api/product/' + $routeParams.id).success(function(data) {
      $scope.product = data;
      Page.setTitle($scope.product.name);
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
  '$scope', '$http', '$routeParams', 'Page', function($scope, $http, $routeParams, Page) {
    $scope.category = $routeParams.category;
    $scope.formReview = {};
    $http.get('/api/products/' + $routeParams.category).success(function(data) {
      $scope.products = data;
      Page.setTitle($routeParams.category);
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
  '$scope', '$http', '$routeParams', 'Page', 'Settings', function($scope, $http, $routeParams, Page, Settings) {
    $scope.formReview = {};
    Settings.async().then(function(d) {
      $scope.settings = d;
      return Page.setTitle($scope.settings.productsTitle);
    });
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
]).controller('AdminControllerSettings', [
  '$scope', '$http', '$routeParams', 'Page', 'Settings', function($scope, $http, $routeParams, Page, Settings) {
    $scope.formSettings = {};
    Settings.async().then(function(d) {
      $scope.formSettings = d;
      Page.setTitle('Admin Panel');
      return Page.setTitle2(' - ' + $scope.formSettings.title);
    });

    /*
    		$http.get('/api/settings')
    	        .success (data) ->
    				$scope.formSettings = data
    				console.log $scope.formSettings
    				return
    			.error (data) ->
    				console.log('Error: ' + data)
    				return
     */
    $scope.editSettings = function() {
      console.log($scope.formSettings);
      $http.post('/api/settings', $scope.formSettings).success(function(data) {
        $scope.formSettings = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    return $scope.addSettings = function() {
      $scope.formSettings.title = 'Gemstore.com';
      $scope.formSettings.footer = 'Footer';
      $scope.formSettings.indexTitle = 'Main Page';
      $scope.formSettings.description = 'Description of Gemstore.com';
      $http.post('/api/asettings', $scope.formSettings).success(function(data) {
        $scope.settings = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
  }
]).controller('AdminControllerSites', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formSite = {};
    $scope.isCollapsedAdd = true;
    $scope.formEditSite = {};
    $scope.isCollapsedEdit = [];
    $scope.isCollapsedShow = [];
    $scope.sitesOrder = [];
    $http.get('/api/sites').success(function(data) {
      var i, _i, _ref;
      $scope.sites = data;
      for (i = _i = 0, _ref = $scope.sites.length - 1; _i <= _ref; i = _i += 1) {
        $scope.isCollapsedEdit[i] = true;
        $scope.isCollapsedShow[i] = true;
      }
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addSite = function() {
      console.log($scope.formSite.title);
      $http.post('/api/site', $scope.formSite).success(function(data) {
        var i, _i, _ref;
        $scope.sites = data;
        for (i = _i = 0, _ref = $scope.sites.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedEdit[i] = true;
          $scope.isCollapsedShow[i] = true;
        }
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
    $scope.startEditSite = function(title, index) {
      console.log(title);
      $http.get('/api/site/' + title).success(function(data) {
        var i, _i, _ref;
        $scope.formEditSite = data;
        for (i = _i = 0, _ref = $scope.sites.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedEdit[i] = true;
        }
        $scope.isCollapsedEdit[index] = !$scope.isCollapsedEdit[index];
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.editSite = function(site) {
      console.log($scope.formEditSite.title + site._id);
      $http.post('/api/site/' + site._id, $scope.formEditSite).success(function(data) {
        site.title = data.title;
        site.content = data.content;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.deleteSite = function(id) {
      if (confirm("Are you sure to delete this site?")) {
        $http["delete"]('/api/site/' + id).success(function(data) {
          var i, _i, _ref;
          $scope.sites = data;
          for (i = _i = 0, _ref = $scope.sites.length - 1; _i <= _ref; i = _i += 1) {
            $scope.isCollapsedEdit[i] = true;
            $scope.isCollapsedShow[i] = true;
          }
          console.log(data);
        }).error(function(data) {
          console.log('Error: ' + data);
        });
      }
    };
    $scope.sortableOptions = {
      stop: function(e, ui) {
        var i, _i, _ref;
        for (i = _i = 0, _ref = $scope.sites.length - 1; _i <= _ref; i = _i += 1) {
          $scope.sitesOrder[i] = $scope.sites[i]._id;
        }
        return console.log($scope.sitesOrder);
      }
    };
    $scope.saveOrder = function() {
      $http.post('/api/sites/order', $scope.sitesOrder);
      $http.get('/api/sites').success(function(data) {
        var i, _i, _ref;
        $scope.sites = data;
        for (i = _i = 0, _ref = $scope.sites.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedEdit[i] = true;
          $scope.isCollapsedShow[i] = true;
        }
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
  }
]).controller('AdminControllerCategories', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formCategory = {};
    $scope.isCollapsedAdd = true;
    $scope.formEditCategory = {};
    $scope.isCollapsedEdit = [];
    $scope.isCollapsedShow = [];
    $http.get('/api/categories').success(function(data) {
      var i, _i, _ref;
      $scope.categories = data;
      for (i = _i = 0, _ref = $scope.categories.length - 1; _i <= _ref; i = _i += 1) {
        $scope.isCollapsedEdit[i] = true;
        $scope.isCollapsedShow[i] = true;
      }
      console.log(data);
    }).error(function(data) {
      console.log('Error: ' + data);
    });
    $scope.addCategory = function() {
      console.log($scope.formCategory.name);
      $http.post('/api/category', $scope.formCategory).success(function(data) {
        var i, _i, _ref;
        $scope.categories = data;
        for (i = _i = 0, _ref = $scope.categories.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedEdit[i] = true;
          $scope.isCollapsedShow[i] = true;
        }
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
    };
    $scope.startEditCategory = function(id, index) {
      $http.get('/api/category/' + id).success(function(data) {
        var i, _i, _ref;
        $scope.formEditCategory = data;
        for (i = _i = 0, _ref = $scope.categories.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedEdit[i] = true;
        }
        $scope.isCollapsedEdit[index] = !$scope.isCollapsedEdit[index];
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.editCategory = function(category) {
      console.log($scope.formEditCategory.name + category._id);
      $http.post('/api/category/' + category._id + '/' + category.name, $scope.formEditCategory).success(function(data) {
        category.name = data.name;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.showProducts = function(name, index) {
      $http.get('/api/products/' + name).success(function(data) {
        var i, _i, _ref;
        $scope.products = data;
        for (i = _i = 0, _ref = $scope.categories.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedShow[i] = true;
        }
        $scope.isCollapsedShow[index] = !$scope.isCollapsedShow[index];
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.deleteCategory = function(category) {
      if (confirm("Are you sure to delete this category with all products?")) {
        $http["delete"]('/api/category/' + category._id + '/' + category.name).success(function(data) {
          var i, _i, _ref;
          $scope.categories = data;
          for (i = _i = 0, _ref = $scope.categories.length - 1; _i <= _ref; i = _i += 1) {
            $scope.isCollapsedEdit[i] = true;
            $scope.isCollapsedShow[i] = true;
          }
          console.log(data);
        }).error(function(data) {
          console.log('Error: ' + data);
        });
      }
    };
  }
]).controller('AdminControllerProducts', [
  '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $scope.formData = {};
    $scope.formImage = {};
    $scope.formEdit = {};
    $scope.isCollapsedAdd = true;
    $scope.isCollapsedEdit = [];
    $scope.isCollapsedShow = [];
    $http.get('/api/products').success(function(data) {
      var i, _i, _ref;
      $scope.products = data;
      for (i = _i = 0, _ref = $scope.products.length - 1; _i <= _ref; i = _i += 1) {
        $scope.isCollapsedEdit[i] = true;
        $scope.isCollapsedShow[i] = true;
      }
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
    $scope.refreshCategories = function() {
      return $http.get('/api/categories').success(function(data) {
        $scope.categories = data;
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.addProduct = function() {
      console.log($scope.formData.category);
      $http.post('/api/product', $scope.formData).success(function(data) {
        var i, _i, _ref;
        $scope.formData = {};
        $scope.products = data;
        for (i = _i = 0, _ref = $scope.products.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedEdit[i] = true;
          $scope.isCollapsedShow[i] = true;
        }
        console.log(data);
      }).error(function(data) {
        console.log('Error: ' + data);
      });
    };
    $scope.deleteProduct = function(id) {
      if (confirm("Are you sure to delete this product?")) {
        $http["delete"]('/api/product/' + id).success(function(data) {
          var i, _i, _ref;
          $scope.products = data;
          for (i = _i = 0, _ref = $scope.products.length - 1; _i <= _ref; i = _i += 1) {
            $scope.isCollapsedEdit[i] = true;
            $scope.isCollapsedShow[i] = true;
          }
          console.log(data);
        }).error(function(data) {
          console.log('Error: ' + data);
        });
      }
    };
    $scope.startEditProduct = function(id, index) {
      console.log(id);
      $scope.editing = true;
      $http.get('/api/product/' + id).success(function(data) {
        var i, _i, _ref;
        $scope.formEdit = data;
        for (i = _i = 0, _ref = $scope.products.length - 1; _i <= _ref; i = _i += 1) {
          $scope.isCollapsedEdit[i] = true;
        }
        $scope.isCollapsedEdit[index] = !$scope.isCollapsedEdit[index];
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
]).controller("LoginController", [
  '$scope', '$http', 'User', function($scope, $http, User) {
    $scope.User = User;
    $scope.formLogin = [];
    $scope.message = [];
    $scope.$watch((function() {
      return User.getName();
    }), function(value) {
      $scope.User.name = value;
    });
    return $scope.login = function() {
      $http.post('/login', {
        email: $scope.formLogin.email,
        password: $scope.formLogin.password
      }).success(function(data) {
        $scope.message = [];
        if (data.length === 1) {
          $scope.message = 'Invalid Email. Try again';
        } else {
          if (data.length === 2) {
            $scope.message = 'Invalid Password. Try again';
          } else {
            console.log(data);
            User.setName(data.local.email);
          }
        }
      }).error(function(data) {
        console.log('Error: ' + data);
      });
      $scope.formReview = {};
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
]).controller('GalleryController', [
  '$rootScope', '$scope', '$http', function($rootScope, $scope, $http) {
    $scope.current = 0;
    $scope.marginValueMin = 0;
    $scope.marginLeftMin = '0px';
    $scope.marginValue = 0;
    $scope.marginLeft = '0px';
    $scope.fullGallery = false;
    $scope.marginValueBig = 0;
    $scope.marginLeftBig = '0%';
    $scope.marginLeftBigBar = '45%';
    $scope.marginValueBigBar = 0;
    $scope.marginLeftBigBarPercentage = '45%';
    $scope.left = function() {
      $scope.marginValueMin += 100;
      $scope.marginLeftMin = $scope.marginValueMin + 'px';
    };
    $scope.right = function() {
      $scope.marginValueMin -= 100;
      $scope.marginLeftMin = $scope.marginValueMin + 'px';
    };
    $scope.leftOne = function() {
      $scope.marginValue += 400;
      $scope.marginLeft = $scope.marginValue + 'px';
    };
    $scope.rightOne = function() {
      $scope.marginValue -= 400;
      $scope.marginLeft = $scope.marginValue + 'px';
    };
    $scope.leftOneBig = function() {
      $scope.marginValueBig += 100;
      $scope.marginLeftBig = $scope.marginValueBig + '%';
      $scope.marginValueBigBar -= 100;
      $scope.marginLeftBigBar = $scope.marginValueBigBar + 'px';
    };
    $scope.rightOneBig = function() {
      $scope.marginValueBig -= 100;
      $scope.marginLeftBig = $scope.marginValueBig + '%';
      $scope.marginValueBigBar += 100;
      $scope.marginLeftBigBar = '-webkit-calc(' + $scope.marginLeftBigBarPercentage + '-' + $scope.marginValueBigBar + 'px);';
      console.log($scope.marginLeftBigBar);
    };
    $scope.setCurrentBig = function(imageNumber) {
      $scope.marginValueBig = -imageNumber * 100;
      $scope.marginLeftBig = $scope.marginValueBig + '%';
      $scope.marginValueBigBar = imageNumber * 100;
      $scope.marginLeftBigBar = $scope.marginValueBigBar + 'px';
    };
    $scope.setCurrent = function(imageNumber) {
      $scope.marginValue = -imageNumber * 400;
      $scope.marginLeft = $scope.marginValue + 'px';
    };
    $scope.showFullGallery = function() {
      $rootScope.hideMenu = true;
      $scope.fullGallery = true;
    };
    $scope.hideFullGallery = function() {
      $rootScope.hideMenu = false;
      $scope.fullGallery = false;
    };
  }
]);
