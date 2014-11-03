train = require 'express-train'
require '../shared/sharedRequire'

trainConfig =
  include: '**/*.js'
  config : '../../config'
  directories : [
    {path : 'lib'}
    {path : 'controllers', aggregateOn : 'controllers'}
    {path : '../shared/models', aggregateOn : 'models'}
  ]

tree = train __dirname, trainConfig

tree.resolve()