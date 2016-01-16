module.exports = (configHelper, packageJson) ->

  result =
    api:
      port: process.env.PORT || 80

    loggerOptions:
      log_level: process.env.LOGGER_LEVEL
      name: packageJson.name

    elasticSearch:
      host: process.env.ELASTIC_DB_HOST || 'localhost:9200'
      log: process.env.ELASTIC_DB_LOG || 'trace'

    validate: () ->
      configHelper.outputConfigValue result, "api.port", true
      configHelper.outputConfigValue result, "loggerOptions.log_level", true
      configHelper.outputConfigValue result, "loggerOptions.name", true

  return result
