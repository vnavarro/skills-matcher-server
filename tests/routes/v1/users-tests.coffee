require('rootpath')()
chai = require('chai')
assert = chai.assert

server = require('tests/stubs/app-server')

describe 'Route Users (V1) - Endpoints', () ->

  before (done) ->
    server.start (err) ->
      done(err)

  after (done) ->
    server.stop () ->
      done()

  it 'it should always return HTTP 200 for all requests', (done) ->
    server.request 'GET', "/v1/users", null, {}, (res) ->
      console.log res
      assert.equal res.statusCode, 200
      done()
