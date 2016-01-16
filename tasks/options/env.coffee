grunt = require('grunt')

# add general test environment variables here, if needed
devEnvironment =
  NODE_ENV: 'development'

  PORT: 3000

  MONGODB_URL: 'mongodb://fitapi:fitapi@ds047355.mongolab.com:47355/fitme'

  MEMCACHE_SERVERS: '192.168.59.103:11211/db'
  MEMCACHE_USERNAME: 'admin'
  MEMCACHE_PASSWORD: 'admin'

  LOGGER_LEVEL: 'DEBUG'

# add local test environment variables here, if needed
#  values added here will overwrite the ones from 'devEnvironment'
testEnvironment = grunt.util._.extend grunt.util._.clone(devEnvironment),
  NODE_ENV: 'test'

  MONGODB_URL: 'mongodb://fitapi:fitapi@ds047355.mongolab.com:47355/fitme'

  MEMCACHE_SERVERS: '192.168.59.103:11211/test'
  MEMCACHE_USERNAME: 'admin'
  MEMCACHE_PASSWORD: 'admin'

# add travis test environment variables here, if needed
#  values added here will overwrite the ones from 'devEnvironment'
travisEnvironment = grunt.util._.extend grunt.util._.clone(devEnvironment),
  NODE_ENV: 'test'

  MONGODB_URL: '192.168.59.103:27017/test'

  MEMCACHE_SERVERS: '192.168.59.103:11211/test'
  MEMCACHE_USERNAME: 'admin'
  MEMCACHE_PASSWORD: 'admin'

module.exports =
  dev: devEnvironment
  travis: travisEnvironment
  test: testEnvironment
