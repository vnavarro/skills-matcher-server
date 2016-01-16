module.exports =
  test:
    src: ['tests/{,**/}*tests.coffee']
    options:
      reporter: 'spec'
      compiler: 'coffee:coffee-script/register'
      timeout: 10000
