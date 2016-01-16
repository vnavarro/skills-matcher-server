env = require('./env')

module.exports =
  app:
    script: 'index.js'
    options:
      cwd: '.'
      nodeArgs: ['--debug=5859']
      ext: 'js,coffee'
      env: env.dev

  'worker-debug':
    script: 'worker-debug.js'
    options:
      cwd: '.'
      nodeArgs: ['--debug=5860']
      ext: 'js,coffee'
      env: env.dev
