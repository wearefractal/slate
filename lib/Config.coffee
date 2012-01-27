class Config
  constructor: ->
    @engines = {}
    @middle = {}
    @production = false
    
  load: (path) -> @set require path
  get: (key) -> @[key] || undefined
  set: (key, val) -> 
    return unless key?
    val ?= true
    if typeof key is 'object'
      @[key] = val for key, val of obj
    else if typeof key is 'string'
      @[key] = val
    else
      # TODO: Throw error?
    return
  
module.exports = Config
