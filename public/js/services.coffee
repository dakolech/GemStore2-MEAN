'use strict';

# Services 


#Demonstrate how to register services
# In this case it is a simple value service.
angular.module('myApp.services', []).
	value('version', '0.2')
.factory('Page', ->
   title = 'Loading'
   title2 = '...'
   description = ''
   return {
     title: -> title,
     setTitle: (newTitle) ->  title = newTitle,
     title2: -> title2,
     setTitle2: (newTitle) ->  title2 = newTitle,
     description: -> description,
     setDescription: (newDescription) ->  description = newDescription
   }
)
.factory('User', ->
   name = false
   isAdmin = false
   return {
     getName: -> name,
     setName: (newName) ->  name = newName,
     isAdmin: -> isAdmin,
     setisAdmin: (newisAdmin) ->  isAdmin = newisAdmin,
   }
)
.factory('Categories', ($http) ->
  myService = {
    async: ->
      if !promise  
        # $http returns a promise, which has a then function, which also returns a promise
        promise = $http.get('/api/categories').then( (response) ->
          # The then function here is an opportunity to modify the response
          console.log(response);
          # The return value gets picked up by the then in the controller.
          return response.data;
        );

      # Return the promise to the controller
      return promise;
  };
  return myService;
)
.factory('Settings', ($http) ->
  myService = {
    async: ->
      if !promise  
        # $http returns a promise, which has a then function, which also returns a promise
        promise = $http.get('/api/settings').then( (response) ->
          # The then function here is an opportunity to modify the response
          console.log(response);
          # The return value gets picked up by the then in the controller.
          return response.data;
        );

      # Return the promise to the controller
      return promise;
  };
  return myService;
);