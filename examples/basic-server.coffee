slate = require '../index.js'
jade = require 'slate-jade'

server = slate.create()
server.root "#{__dirname}/public"
server.enable 'csrf', 'lfi', 'xss', '404', 'mime', 'static'


server.engine 'jade', jade
server.set 'production'
server.listen 8080

console.log "Server started!"

# wscat -c ws://localhost:8080/
server.socket.route '/', (socket) ->
  console.log "Client connected"
  socket.on 'close', -> console.log "Client disconnected"
  socket.on 'message', (message) -> 
    socket.send 'ay yo waz gud wurld'
    
# wscat -c ws://localhost:8080/helloworld/
server.socket.route '/hello', (socket) ->
  console.log "Client connected"
  socket.on 'close', -> console.log "Client disconnected"
  socket.on 'message', (message) -> 
    socket.send 'hello world!'
