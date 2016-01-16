module.exports = (dataHandling, schemas) ->

  User: dataHandling.model(schemas.user, 'user')
