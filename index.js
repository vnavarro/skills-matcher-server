require('coffee-script/register');
require('rootpath')();

module.exports = require('src/server')(function() {console.log('app is ready to listen!')})
