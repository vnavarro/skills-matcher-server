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
      assert.equal res.statusCode, 200
      done()

  it 'it should return user with id 1', (done) ->
    server.request 'GET', "/v1/user/1", null, {}, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it should return user with id 2', (done) ->
    server.request 'GET', "/v1/user/2", null, {}, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it shouldnt return user', (done) ->
    server.request 'GET', "/v1/user/99", null, {}, (res) ->
      assert.equal res.statusCode, 200
      assert.equal res.json, "{ error: 1000, msg: 'User does not exists' }"
      done()

  it 'it should create user', (done) ->
    body = { name: "jessica", role: "dev", area: "product", skills: ["c#"] }
    server.request 'POST', "/v1/user", body, {}, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it should update user', (done) ->
    server.request 'PUT', "/v1/user/1", null, { params: { name: "Jessica" } }, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it should delete user', (done) ->
    server.request 'DELETE', "/v1/user/1", null, {}, (res) ->
      assert.equal res.statusCode, 200
      done()
