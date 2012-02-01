slate = require '../index.js'
jade = require 'slate-jade'

server = slate.create()
server.root "#{__dirname}/public"
server.enable 'csrf', 'lfi', 'xss', '404', 'mime', 'static'


server.engine 'jade', jade
server.set 'production'
server.listen 8080

console.log "Server started!"

# wscat -c ws://localhost:8080 -p 8
server.socket.on 'connection', (socket) ->
  socket.on 'message', (message) ->
    socket.send 'hey' if message is 'hi'
