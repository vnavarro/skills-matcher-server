module.exports = (express) ->

  appRouter = express.Router()

  return (app) ->
    appRouter.get '/users', (req, res) ->
      res.json [ {name: 'Jessica'}, {name: 'Dero'}]

    appRouter.get '/user/:id', (req, res) ->
      res.json
        name: 'Jessica'

    appRouter.post '/user', (req, res) ->
      res.json
        name: req.body.name
        role: req.body.role
        area: req.body.area
        skills: req.skills

    appRouter.put '/user/:id', (req, res) ->
      res.json
        name: req.params.name

    appRouter.delete '/user/:id', (req, res) ->
      res.send({ msg: "Success" })

    app.use '/', appRouter
