module.exports = (config, request) ->

  getApiHandler: (params = {}) ->
    apiConfig =
      hostname: config.api.hostname
      path: config.api.path
      port: config.api.port

    handler = request.config(apiConfig)
    return handler
