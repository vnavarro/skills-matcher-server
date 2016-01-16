module.exports = (grunt) ->

  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  config =
    cwd: process.cwd()

  loadConfig = (path) ->
    glob = require("glob")
    object = {}
    key = undefined
    glob.sync("*",
      cwd: path
    ).forEach (option) ->
      key = option.replace(/\.(js|coffee)$/, "")
      object[key] = require(path + option)

    return object

  grunt.util._.extend config, loadConfig("#{config.cwd}/tasks/options/")

  grunt.initConfig config

  grunt.loadTasks "#{config.cwd}/tasks"
