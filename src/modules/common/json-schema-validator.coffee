module.exports = (validator) ->
  validationObject =
    validate: (schema, data) ->
      validator.addSchema schema
      if data.constructor == Array then dataArray = data else dataArray = [data]
      valid = true
      errors = []
      for item in dataArray
        validation = validator.validate(item, schema)
        if validation.errors.length > 0
          valid = false
          errors.push validation.errors
      validationResults =
        valid: valid
        errors: errors
      return validationResults
  return validationObject
