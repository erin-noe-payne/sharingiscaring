_ = require 'lodash'

module.exports = (User) ->
  controller = {}

  models = [
    {name : 'erin', birthday : '9/14/86', secret : 'Shhh dont tell'}
    {name : 'caitlin', birthday : '9/3/86', secret : 'A trial by fire'}
  ]

  users = {}

  for u in models
    user = new User(u)
    users[user.id] = user

  controller.create = (req, res, next) ->
    user = new User(req.body.user)
    errors = user.validate()

    if errors
      res.status(500).json {errors}
    else
      users[user.id] = user
      res.status(201).json user

  controller.read = (req, res, next) ->
    {id} = req.params
    user = users[id]

    if user
      res.json user
    else
      res.send 404

  controller.readAll = (req, res, next) ->
    res.json _.toArray users

  controller.update = (req, res, next) ->
    {id} = req.params

    user = users[id]
    if !user
      return res.send 404

    model = req.body.user

    for k, v of model
      user[k] = v

    errors = user.validate()
    if errors
      res.status(500).json {errors}
    else
      res.status(200).json user

  controller.delete = (req, res, next) ->
    {id} = req.params

    user = users[id]
    if !user
      return res.send 404

    delete users[id]
    res.send 200


  return controller