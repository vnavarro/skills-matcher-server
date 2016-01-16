module.exports =
  compile:
    files: [
      expand: true
      cwd: 'src'
      src: ['{,**/}*.coffee', '!**/node_modules/**']
      dest: '.tmp'
      ext: '.js'
    ]
    options:
      sourceMap: true
