slate = require '../index.js'

server = slate.create()

server.root "#{__dirname}/public"
server.enable 'csrf', 'lfi', 'xss', '404', 'mime', 'json', 'static'
server.set 'production'
server.set 'debug', false

server.listen 8080
console.log "Server started!"
