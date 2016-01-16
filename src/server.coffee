app = {}
app.packageJson = require('../package.json')
app.express = require('express')
app.bodyParser = require('body-parser')
app.dataHandling = require('node-data-handling')()
app.jsonschema = require('jsonschema')
app.validator = new app.jsonschema.Validator()
app.configHelper = require('tq1-helpers').config_helper

core = {}

# Config
core = {}
core.config = require('src/core/config/config') app.configHelper, app.packageJson

# Logs
# require('tq1-logger')(core.config.loggerOptions, console)

# Common Module
common = {}
common.jsonSchemaValidator = require('src/modules/common/json-schema-validator') app.validator

# Http Module
core.http = {}
core.http.mixin = require('src/core/http/mixin.coffee')()
core.http.responseBuilder = require('src/core/http/response-builder.coffee') common.jsonSchemaValidator

# Common middlewares
common.middlewares = {}
common.middlewares.mobileRequestValidator = require('src/modules/common/middlewares/mobile-request-validator-middleware') core.http.responseBuilder, common.jsonSchemaValidator

# Database
db = {}
db.schemas = {}
db.schemas.user = require('src/db/schemas/user')
db.schemas.skill = require('src/db/schemas/skill')
db.db = require('src/db/db') app.dataHandling, db.schemas

# Routes
routes_version =
  v1:
    users: require('src/routes/v1/users') app.express
    skills: require('src/routes/v1/skills') app.express, db.db.Skill
routes = require('src/routes/routes') app.express, core.config, routes_version


module.exports = (callback) ->
  return require('src/app') app.express, app.bodyParser, core.config, routes, callback
