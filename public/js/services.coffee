'use strict';

# Services 


#Demonstrate how to register services
# In this case it is a simple value service.
angular.module('myApp.services', []).
	value('version', '0.2')
	#.factory('ProductService', [ '$resource', ($resource) ->
	  #  return $resource('/product/:id', {
	  #      id : '@_id'
	  #      });
		# ]);
