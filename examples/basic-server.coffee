slate = require '../index.js'

server = slate.create()

server.root "#{__dirname}/public"
server.enable '404', 'mime', 'static'
server.set 'production'
server.set 'debug', false

server.listen 8080
console.log "Server started!"
