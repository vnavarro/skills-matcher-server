require('rootpath')()
proxyquire = require('proxyquire')
querystring = require('querystring')
http = require('http')
_ = require('lodash')

port = process.env.PORT
app = null
server = null
stubs = {}

defaultHttpOptions = (method, path, body = null, headers = {}) ->

  newHeaders = _.assign( 'Content-Type': 'application/json', headers )

  options =
    'host': 'localhost'
    'port': port
    'path': path
    'method': method
    'headers': newHeaders

  return options

app_server =

  stubs: (obj) ->
    stubs = obj

  start: (callback) ->
    if not server
      if stubs
        server = proxyquire 'src/server', stubs
      else
        server = require 'src/server'

      app = server (err) ->
        return callback(err) if err
        return callback() if not err

  stop: (callback) ->
    app.close () ->
      callback()

  request: (method, path, body, headers = {}, callback) ->
    responseBody = ""
    body_json = JSON.stringify(body) if body

    req = http.request defaultHttpOptions(method, path, body_json, headers), (res) ->
      responseData = ""
      res.on("data", (chunk) ->
        responseData += chunk.toString())
      res.on("end", () ->
        try
          callback(res, JSON.parse(responseData)) if callback?
        catch error
          console.log "[JSON.parse] Err: #{error}")
    req.write(body_json) if body
    req.end()

module.exports = app_server
