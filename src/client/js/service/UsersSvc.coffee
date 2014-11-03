angular.module('myApp').service 'UsersSvc', ($http) ->
  User = Scheming.get 'User'

  new class UsersSvc
    read : ->

    readAll : (cb) ->
      $http.get('/api/users').success (data) ->
        users = []
        for u in data
          users.push new User(u)

        cb null, users

    create : (model, cb) ->
      user = new User model
      errors = user.validate()
      if errors
        cb errors
      else
        $http.post('/api/users', {user}).success ->
          cb null, user

    update : ->

    destroy : ->


