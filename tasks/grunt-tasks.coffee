module.exports = (grunt) ->

  grunt.registerTask 'default', [
    'coffeelint'
    'concurrent'
  ]

  grunt.registerTask 'test', [
    'env:test'
    'coffeelint'
    'mochaTest'
  ]

  grunt.registerTask 'travis', [
    'env:travis'
    'coffeelint'
    'mochaTest'
  ]
