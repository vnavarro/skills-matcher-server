module.exports = (mixin, querystring, httpHandler) ->

  class Request

    constructor: (basicHeaders) ->
      @requestMixin = mixin.create(basicHeaders)
      @paramsMixin = mixin.create()

      @method = 'GET' #default method

      @responseCallback = (contents) =>

        if @thenCallback?
          @thenCallback(contents)
        else
          throw new Error("Hey, don't forget to set thenCallback!!!!")

    addHeaders: (header) ->
      @requestMixin.add({headers: header})
      return @

    addParams: (params) ->
      @paramsMixin.add(params)
      return @

    get: (endpoint) ->
      @endpoint = endpoint
      @method = 'GET'
      return @

    post: (endpoint, data) ->
      @method = 'POST'
      @endpoint = endpoint
      @data = data
      return @

    then: (thenCallback) ->
      @thenCallback = thenCallback
      return @

    commit: () ->
      pathBuilder = @requestMixin.get('path') + @endpoint
      pathBuilder += "?" + querystring.stringify(@paramsMixin.mix()) if @paramsMixin.count() > 0

      @requestMixin.add(
        method: @method
        path: pathBuilder
      )

      options = @requestMixin.mix()

      if @method is 'GET'
        httpHandler.get(options, @thenCallback)
      else
        httpHandler.post(options, @data, @thenCallback)

      return

  request =
    config: (config) ->
      return new Request(config)
