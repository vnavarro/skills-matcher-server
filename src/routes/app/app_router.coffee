module.exports =
  route: (app) ->

    app.get '/', (req, res) ->
      res.send 'Hello World!'
