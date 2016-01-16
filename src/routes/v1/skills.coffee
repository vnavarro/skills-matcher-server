module.exports = (express) ->

  appRouter = express.Router()

  return (app) ->
    appRouter.get '/skills', (req, res) ->
      res.json [ {tag: 'C#'}, {tag: 'nodejs'}]

    appRouter.get '/skill/:tag', (req, res) ->
      res.json
        tag: 'nodejs'

    appRouter.post '/skill', (req, res) ->
      res.json
        tag: req.body.tag

    appRouter.put '/skill/:tag', (req, res) ->
      res.json
        tag: req.params.tag

    appRouter.delete '/skill/:tag', (req, res) ->
      res.send({ msg: "Success" })

    app.use '/', appRouter
