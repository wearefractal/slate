slate = require '../index.js'
jade = require 'jade'
hogan = require 'hogan.js'

server = slate.create()

server.root "#{__dirname}/public"
server.enable 'csrf', 'lfi', 'xss', '404', 'mime', 'static'
#server.engine 'jade', jade, {some: 'options'}

params =
  data:
      header: "Colors"
      items: [
          {name: "red", first: true, url: "#Red"}
          {name: "green", link: true, url: "#Green"}
          {name: "blue", link: true, url: "#Blue"}
      ]
    
server.engine 'mustache', hogan, params

hogan = require 'hogan.js'
compile = hogan.compile
compiled = compile '{{test}}'
rendered = compiled.render test: "hi"
console.log rendered

server.set 'production'
server.set 'debug', false

server.listen 8080
console.log "Server started!"
