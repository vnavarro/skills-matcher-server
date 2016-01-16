module.exports = (express, config, request, _) ->

  appRouter = express.Router()

  return (app) ->
    appRouter.get '/users', (req, res) ->
      options =
        url: 'http://localhost:9200/fitme/user/_search'
        method: 'GET'

      request options, (err, resp) ->
        if not err?
          res.json _.pluck JSON.parse(resp.body).hits.hits, '_source'
        else
          res.sendStatus 400

    appRouter.get '/user/:id', (req, res) ->
      id = req.params.id
      options =
        url: "http://localhost:9200/fitme/user/#{id}"
        method: 'GET'

      request options, (err, resp) ->
        if not err?
          res.json JSON.parse(resp.body)._source
        else
          res.sendStatus 400

    appRouter.post '/user', (req, res) ->
      options =
        url: "http://localhost:9200/fitme/user/"
        method: 'POST'
        json: true
        body:
          name: req.body.name
          role: req.body.role
          area: req.body.area
          photo: req.body.photo
          skills: req.body.skills

      request options, (err, resp) ->
        if not err?
          res.json resp.body
        else
          res.sendStatus 400

    appRouter.put '/user/:id', (req, res) ->
      id = req.params.id
      options =
        url: "http://localhost:9200/fitme/user/#{id}"
        method: 'PUT'
        json: true
        body:
          name: req.body.name
          role: req.body.role
          area: req.body.area
          photo: req.body.photo
          skills: req.skills

      request options, (err, resp) ->
        if not err?
          res.json resp.body
        else
          res.sendStatus 400

    appRouter.delete '/user/:id', (req, res) ->
      res.send({ msg: "Success" })

    app.use '/', appRouter
