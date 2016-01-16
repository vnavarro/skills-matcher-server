var AppRouter, app, express;

express = require('express');

app = express();

AppRouter = require('./routes/app/app-router');

app.listen(3000, function() {
  return console.log('Example app running on 3000!');
});

AppRouter.route(app);
