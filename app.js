var express = require('express');
var app = express();

var AppRouter = require('./routes/app/app-router');

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});

AppRouter.route(app);
