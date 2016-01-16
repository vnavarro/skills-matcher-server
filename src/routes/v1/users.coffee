module.exports = (express) ->

  appRouter = express.Router()

  return (app) ->
    appRouter.get '/', (req, res) ->
      res.json
        title: "HELLO!!!"

    app.use '/users', appRouter
