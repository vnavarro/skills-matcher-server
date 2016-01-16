module.exports = (grunt) ->

  # configuration
  grunt.initConfig

    # grunt coffee
    coffee:
      glob_to_multiple:
        expand: true
        flatten: false
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'dist'
        ext: '.js'
        options:
          bare: true
          preserve_dirs: true

    copy:
      main:
        files:[
          expand: true
          cwd: 'src'
          src: ['**/*.json']
          dest: 'dist'
        ]

    # grunt watch
    watch:
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee']
      json:
        files: ['src/**/*.json']
        tasks: ['copy']

    # grunt mocha tests
    mochaTest:
      test:
        src: ['tests/{,**/}*tests.coffee']
        options:
          reporter: 'spec'
          compiler: 'coffee:coffee-script/register'
          timeout: 10000

    # load plugins
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-mocha-test'

    # tasks
    grunt.registerTask 'default', ['copy', 'coffee', 'mochaTest' , 'watch']
    grunt.registerTask 'test', ['mochaTest']
