module.exports = (express, config, routeVersion) ->

  return (app) ->

    # Route v1
    route_v1 = express.Router()
    for key, value of routeVersion.v1
      value route_v1

    # Example Next Version Use
    # Route v2
    # route_v2 = express.Router()
    # for key, value of route_versions.v2
    #   value route_v2

    # app.use('/v2', route_v2, route_v1)
    app.use('/v1', route_v1)
