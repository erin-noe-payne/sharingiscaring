module.exports = (config, app) ->
  server = app.listen config.port

  return server