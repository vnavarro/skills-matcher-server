require('rootpath')()
chai = require('chai')
assert = chai.assert

server = require('tests/stubs/app-server')

describe 'Route Skills (V1) - Endpoints', () ->

  before (done) ->
    server.start (err) ->
      done(err)

  after (done) ->
    server.stop () ->
      done()

  it 'it should always return HTTP 200 for all skills', (done) ->
    server.request 'GET', "/v1/skills", null, {}, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it should return skill with tag nodejs', (done) ->
    server.request 'GET', "/v1/skill/nodejs", null, {}, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it should return skill with id mongodb', (done) ->
    server.request 'GET', "/v1/skill/mongodb", null, {}, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it shouldnt return skill', (done) ->
    server.request 'GET', "/v1/skill/99", null, {}, (res) ->
      assert.equal res.statusCode, 500
      done()

  it 'it should create skill', (done) ->
    body = { tag: "nodejs" }
    server.request 'POST', "/v1/skill", body, {}, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it should update skill', (done) ->
    server.request 'PUT', "/v1/skill/1", null, { params: { tag: "Jessica" } }, (res) ->
      assert.equal res.statusCode, 200
      done()

  it 'it should delete skill', (done) ->
    server.request 'DELETE', "/v1/skill/1", null, {}, (res) ->
      assert.equal res.statusCode, 200
      done()
