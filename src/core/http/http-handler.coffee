module.exports = (http, replay, config, responseBuilder, responseStringfy) ->

  # TODO: Implement retry logic
  maxAttempts = config.api.httpMaxAttempts

  if replay?
    replay.mode = 'bloody'
    if (process.env.NODE_ENV is 'development')
      #TODO: Uncomment this line later...
      replay.mode = 'bloody'
    else if (process.env.NODE_ENV is 'test')
      replay.mode = 'replay'

  defaultRequest = (options, callback, data) ->

    replay.fixtures = __dirname + '/fixtures/' + options.path.split('?')[0] if replay?


    console.log "[requestDispatcher] Starting request..." if process.env.NODE_ENV != 'test'
    myRequest = http.request(options, (response) ->

      console.log "[requestDispatcher] http callback" if process.env.NODE_ENV != 'test'
      responseBody = ""
      response.on "data", (chunk) ->
        responseBody += chunk.toString()

      response.on "end", () ->
        console.log "[requestDispatcher] Request Ended!" if process.env.NODE_ENV != 'test'

        responseObject = null
        console.log responseBody

        try
          responseObject = JSON.parse(responseBody)

          # Parse all values to string!!
          responseObject = responseStringfy.transform responseObject

        catch error
          console.error "JSON.parse failed!"
          callback responseBuilder.build("Serviço temporariamente indisponível.", responseBuilder.ErrorType.INVALID_REQUEST_PARAMS)

        if callback?
          callback responseBuilder.build(responseObject)
        else
          throw new Error("You forgot to set the callback")

      )
      .on('error', (err) ->
        callback(responseBuilder.build(err, responseBuilder.ErrorType.INVALID_RESPONSE_DATA))

      )
      .on('socket', (socket) ->

        socket.setTimeout(15000)

        socket.on('timeout', () ->
          console.error "[requestDispatcher] Request aborted. Connection to Server timedout"

          callback(responseBuilder.build("Serviço temporariamente indisponível.", responseBuilder.ErrorType.REQUEST_TIMEOUT))
          myRequest.abort()
        )
      )


    if data
      console.log "[requestDispatcher] Writing data..." if process.env.NODE_ENV != 'test'
      myRequest.write(JSON.stringify data) if data
    myRequest.end()

  requestTypes =
    get: (options, callback) ->
      defaultRequest options, callback
    post: (options, postData, callback) ->
      defaultRequest options, callback, postData

  return requestTypes
