module.exports =
  main:
    tasks: ['nodemon:app', 'node-inspector']
    options:
      logConcurrentOutput: true

  'worker-debug':
    tasks: ['nodemon:worker-debug', 'node-inspector']
    options:
      logConcurrentOutput: true
