express = require 'express'
bodyParser = require 'body-parser'
path = require 'path'

module.exports = (app, UsersCtrl) ->
  app.set 'views', path.resolve __dirname, '../../views'
  app.engine 'jade', require('jade').__express
  app.set 'view engine', 'jade'

  app.use express.static path.resolve __dirname, '../../client'
  app.use express.static path.resolve __dirname, '../../shared'
  app.use express.static path.resolve __dirname, '../../../bower_components'
  app.use bodyParser.json()

  app.get '/users', (req, res) ->
    res.render 'users'
  app.get '/accounts', (req, res) ->
    res.render 'accounts'

  app.get '/api/users', UsersCtrl.readAll
  app.get '/api/users/:id', UsersCtrl.read
  app.post '/api/users', UsersCtrl.create
  app.post '/api/users/:id', UsersCtrl.update
  app.delete '/api/users/:id', UsersCtrl.delete
