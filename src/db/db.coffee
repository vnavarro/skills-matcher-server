module.exports = (dataHandling, schemas) ->

  User: dataHandling.model(schemas.user, 'user')
  Skill: dataHandling.model(schemas.skill, 'skill')
