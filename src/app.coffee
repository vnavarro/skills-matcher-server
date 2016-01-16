module.exports = (express, bodyparser, config, router, callback) ->

  config.validate()

  app = express()
  app.disable('x-powered-by') # https://speakerdeck.com/ckarande/top-overlooked-security-threats-to-node-dot-js-web-applications?slide=57

  app.use bodyparser.json() # for parsing application/json

  # Route requests
  router app

  app.use (err, req, res, next) ->
    if err
      console.error "[app][error]" + err.stack
    next(err)

  return app.listen config.api.port, callback
