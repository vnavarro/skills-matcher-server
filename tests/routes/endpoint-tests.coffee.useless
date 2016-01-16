require('rootpath')()
_ = require('lodash')
chai = require('chai')
expect = chai.expect
assert = chai.assert
sinon = require('sinon')
walk = require('walk')
packageJson = require('package.json')

# Config helpers
configHelper = require('tq1-helpers').config_helper
config = require('src/core/config/config') configHelper, packageJson

server = require('tests/stubs/app-server')

stubs =
  'tq1-logger': () ->

aggregateTestFiles = (files, path) ->
  tests = {}
  for file in files
    f = (arr, obj, path) ->
      if not arr or arr.length <= 1
        file = {}
        file[path + '/' + arr.shift().split('.')[0]] = null
        return file

      first = arr.shift()
      if Object.keys(obj).indexOf(first) < 0
        obj[first] = {}
      obj[first] = f(arr, obj[first], path + '/' + first)
      return obj

    tests = f(file, tests, path)
  return tests

getTestFiles = (path, posfix) ->
  files = []
  options =
    followLinks: false
    listeners:
      file: (root, fileStats, next) ->
        name = fileStats.name
        if name.slice(0 - posfix.length) == posfix
          files.push (root+'/'+name).replace(path + '/', '').split('/')
        next()

  walk.walkSync path, options
  return aggregateTestFiles files, path

before (done) ->
  server.stubs stubs
  server.start ((err) ->
    console.log "\n\nTesting app modules...\n"
    done (err))

after (done) ->
  server.stop () ->
    done()

describe 'Modules', () ->

  tests = getTestFiles 'src/modules', '-tests.coffee'

  recursiveDescribe = (obj) ->
    if typeof(obj) == "object" and Object.keys(obj)
      for key in Object.keys(obj)
        if obj[key]
          formatedKey = (key.split('-').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '
          describe formatedKey, () ->
            recursiveDescribe(obj[key])
        else
          require(key)(server, assert, () -> done())
  recursiveDescribe(tests)
