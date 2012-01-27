{EventEmitter} = require 'events'
Config = require './Config'
HttpServer = require './HttpServer'

class Slate extends EventEmitter
  config: new Config()
  http: new HttpServer()
  
  # Convenience
  root: (dir) -> @set 'root', dir 
  engine: (args...) -> @http.engine args...
  use: (args...) -> @http.use args...
  enable: (args...) -> @http.enable args...
  disable: (args...) -> @http.disable args...
  
  set: (args...) -> @config.set args... 
  get: (args...) -> @config.get args...
  
  listen: (port, host) ->
    @http.listen port, host, @config

module.exports = Slate
