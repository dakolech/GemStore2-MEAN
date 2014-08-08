'use strict';

# Services 


#Demonstrate how to register services
# In this case it is a simple value service.
angular.module('myApp.services', []).
	value('version', '0.2')
.factory('Page', ->
   title = 'Loading'
   title2 = '...'
   return {
     title: -> title,
     setTitle: (newTitle) ->  title = newTitle,
     title2: -> title2,
     setTitle2: (newTitle) ->  title2 = newTitle  
   }
)
	#.factory('ProductService', [ '$resource', ($resource) ->
	  #  return $resource('/product/:id', {
	  #      id : '@_id'
	  #      });
		# ]);
