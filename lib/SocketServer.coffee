{Server} = require 'ws'
{EventEmitter} = require 'events'

class SocketServer extends EventEmitter
  constructor: (@config) ->
  
  listen: (server) ->
    @wss = new Server {server: server}
    @wss.on 'connection', (socket) => @emit 'connection', socket
    @emit 'ready'
    return @wss
  
module.exports = SocketServer
