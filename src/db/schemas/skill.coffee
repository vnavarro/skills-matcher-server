module.exports = (mongoose, mongooseAlias, statics) ->
  class Skill
    constructor: (collection) ->
      @schema = new mongoose.Schema
        tag: { type: "string", default: null, unique: true }
        related: { type: mongoose.Schema.Types.Mixed, default: [] }

      @schema.plugin(mongooseAlias)

      @schema.statics = statics

      return @schema
