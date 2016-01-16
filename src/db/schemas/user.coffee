module.exports = (mongoose, mongooseAlias, statics) ->
  class User
    constructor: (collection) ->
      @schema = new mongoose.Schema
        name: {"type": "string", "default": null}

      @schema.plugin(mongooseAlias)

      @schema.statics = statics

      return @schema
