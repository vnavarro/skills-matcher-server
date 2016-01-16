module.exports = (responseBuilder, validator) ->

  validation = (schema, toValidate) ->
    middleware = (req, res, next) ->

      fail = (property) ->
        responseBuilder.build("Invalid field #{property}.", responseBuilder.ErrorType.INVALID_REQUEST_PARAMS).send(res)

      data = null
      if toValidate == 'query'
        data = req.query
      else if toValidate == 'body'
        data = req.body
      else
        next()

      validation = validator.validate(schema, data)
      if validation.valid
        next()
      else
        fail(validation.errors[0][0].property.split(".")[1])

    return middleware
  return validation
