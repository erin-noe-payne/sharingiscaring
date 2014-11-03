angular.module('myApp').controller 'UsersCtrl', ($scope, UsersSvc) ->
  $scope.users = []

  $scope.editUser = {}
  $scope.errors = {}

  resetEdit = ->
    $scope.errors = {}
    $scope.editUser =
      name : ''
      birthday : ''
      secret : ''

  resetEdit()

  UsersSvc.readAll (err, users) ->
    $scope.users = users

  $scope.addUser = ->
    UsersSvc.create $scope.editUser, (errors, user) ->
      if errors
        $scope.errors = errors
      else
        resetEdit()

        $scope.users.push user

  $scope.removeUser = (index) ->
    console.log 'heyo'



