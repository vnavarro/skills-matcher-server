module.exports = {
  route: function(app) {
    return app.get('/', function(req, res) {
      return res.send('Hello World!');
    });
  }
};
