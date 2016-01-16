module.exports = (express, skillModel) ->

  appRouter = express.Router()
  skill = skillModel

  return (app) ->
    appRouter.get '/skills', (req, res) ->
      tags = req.query.tags
      if tags
        tags = tags.split ","
        skill.where("tag").in(tags).exec (error, response) ->
          if error
            res.send 500, { error: "Couldn't find skills." }
          res.json response
      else
        skill.find "", (error, response) ->
          if error
            res.send 500, { error: "Couldn't find skills." }
          res.json response

    appRouter.get '/skill/:tag', (req, res) ->
      skill.findOne
        tag: req.params.tag
        , (error, response) ->
          if error
            res.send 500, { error: "Couldn't find skill." }
          res.json response || {}

    appRouter.post '/skill', (req, res) ->
      skill.create
        tag: req.body.tag
        ,
        related: req.body.related
        , (error, response) ->
          if error
            res.json response
            #res.send 500, { error: "Couldn't create skill." }
          res.json response

    appRouter.put '/skill/:tag', (req, res) ->
      tag = req.params.tag
      related = req.body.related
      skill.update
        tag: tag
      ,
        $addToSet:
          related:
            $each: related
      ,
        upsert: true
      , (error, doc) ->
        if error
          res.send 500, { error: "Couldn't update skill." }
        res.json doc

    appRouter.delete '/skill/:tag', (req, res) ->
      skill.findOne
        tag: req.params.tag
        , (error, response) ->
          if error
            res.send 500, { error: "Skill not found." }
          if response
            skill.delete response._id, (error, response) ->
              res.send response
          else
            res.send 500, { error: "Couldn't delete skill" }

    app.use '/', appRouter
