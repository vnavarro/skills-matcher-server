module.exports = () ->
  class Mixin

    constructor: (obj) ->
      @child = if obj? then obj else {}

    add: (obj) ->
      for prop of obj
        if @child.hasOwnProperty(prop) and @child[prop] instanceof Object
          @child[prop] = new Mixin(obj[prop]).add(@child[prop]).mix()
        else
          @child[prop] = obj[prop] if obj.hasOwnProperty(prop)

      return @

    get: (prop) ->
      @child[prop]

    count: () ->
      Object.keys(@child).length

    mix: () ->
      @child

  mixin =
    create: (obj) ->
      return new Mixin(obj)


  return mixin