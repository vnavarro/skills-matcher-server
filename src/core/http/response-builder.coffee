Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

module.exports = (jsonSchemaValidator) ->


  class ErrorType
    @INVALID_REQUEST_PARAMS       = {statusCode: 400, errorCode: "INVALID_REQUEST_PARAMS"}
    @UNAUTHORIZED_ERROR           = {statusCode: 401, errorCode: "UNAUTHORIZED_ERROR"}
    @FORBIDDEN_ERROR              = {statusCode: 403, errorCode: "FORBIDDEN_ERROR"}
    @NOT_FOUND                    = {statusCode: 404, errorCode: "NOT_FOUND"}
    @REQUEST_TIMEOUT              = {statusCode: 408, errorCode: "REQUEST_TIMEOUT"}
    @USER_ALREADY_EXISTS          = {statusCode: 409, errorCode: "USER_ALREADY_EXISTS"}
    @VERSION_ERROR                = {statusCode: 415, errorCode: "VERSION_NOT_SUPPORTED"}
    @INVALID_RESPONSE_DATA        = {statusCode: 422, errorCode: "INVALID_RESPONSE_DATA"}
    @TOO_MANY_REQUESTS            = {statusCode: 429, errorCode: "TOO_MANY_REQUESTS"}
    @DATABASE_ERROR               = {statusCode: 500, errorCode: "DATABASE_ERROR"}

  Object.freeze(ErrorType)

  class Response
    @property 'isSuccess',
      get: -> return not @errorType?

    constructor: (data, errorType) ->

      @data = data || {}
      @headers = {}
      if errorType?
        @errorType = errorType

      return @

    addHeaders: (headers) ->
      @headers = headers
      return @

    validate: (schema) ->
      #Don't validate if there are  errors  already
      if not @isSuccess
        return @


      validationResult = jsonSchemaValidator.validate(schema, @data)
      if validationResult.valid isnt true
        @errorType = ErrorType.INVALID_RESPONSE_DATA
        @data = validationResult.errors

      return @

    transform: (object) ->

      #Don't pipe is there are errors
      if not @isSuccess
        return @

      return new Response(object)



    parse: (parser) ->

      #Don't parse if there are  errors  already
      if not @isSuccess
        return @


      parseOneContent = (parser, content) ->
        toObjKeys = Object.keys(parser)

        parsedContent = {}
        for index in [0..toObjKeys.length] by 1

          toObjKey = toObjKeys[index] #get destination key
          fromObjKey = parser[toObjKey] #get origin key

          parsedContent[toObjKey] = content[fromObjKey]

        return parsedContent


      #parse each item in the array
      if typeof @data  == Array
        parseddata = []

        for index in [0..@data.length] by 1
          parsedContent = parseOneContent(parser, @data[i])
          parseddata.push(parsedContent)

        @data = parseddata

      else
        parsedContent = parseOneContent(parser, @data)
        @data = parsedContent

      return @


    send: (res) ->

      statusCode = 200
      response =
        isSuccess: @isSuccess
        data: @data

      if @errorType?
        response.data = {errorCode: @errorType.errorCode, errors: @data}
        statusCode = @errorType.statusCode

      if @headers?
        res.set @headers

      if @isSuccess and typeof(response.data) == 'object' and Object.keys(response.data).length == 0
        statusCode = 204
        response = null

      res.status(statusCode).send(response)


  responseBuilder =
    ErrorType: ErrorType
    build: (data, errorType) ->

      if arguments.length is 2 and not errorType?
        throw new Error("Invalid ErrorType in ResponseBuilder.build(data, errorType)")

      if data instanceof Response
        return data

      if not data?
        return new Response()

      if data.hasOwnProperty('error')
        return new Response(data.errorDescription, ErrorType.INVALID_REQUEST_PARAMS)

      return new Response(data, errorType)

  return responseBuilder
