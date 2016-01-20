module.exports = (express, config, request, _) ->

  searchRouter = express.Router()

  return (app) ->
    searchRouter.get '/search', (req, res) ->
      tags = req.query.tags.split ","
      match = []
      for tag in tags
        match.push
          match:
            'skills.tag': tag

      options =
        url: 'http://localhost:9200/fitme/user/_search'
        method: 'POST'
        json: true
        body:
          query:
            bool:
              must: [
                {
                  nested:
                    path: 'skills'
                    query:
                      function_score:
                        functions: [
                          script_score:
                            script: "return doc['skills.weight'].value"
                        ],
                        query:
                          bool:
                            should: match
                }
              ]

      request options, (err, resp) ->
        if not err?
          hits = resp.body.hits
          hits.tags = tags
          hits.hits = _.pluck hits.hits, '_source'
          users = []
          for user in hits.hits
            all = true
            skills = _.pluck user.skills, 'tag'
            for tag in tags
              if not _.contains skills, tag
                all = false
            users.push(user) if all
          hits.hits = users
          hits.total = users.length

          res.json hits
        else
          res.sendStatus 400

    app.use '/', searchRouter
