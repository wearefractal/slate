slate = require '../index.js'
#jade = require 'slate-jade'
hogan = require 'slate-hogan'

server = slate.create()

server.root "#{__dirname}/public"
server.enable 'csrf', 'lfi', 'xss', '404', 'mime', 'static'

data = 
  header: "Colors"
  items: [
	  {name: "red", first: true, url: "#Red"}
	  {name: "green", link: true, url: "#Green"}
	  {name: "blue", link: true, url: "#Blue"}
  ]

options = {}

server.engine 'mustache', hogan, data, options
#server.engine 'jade', jade, data, options

server.set 'production'

server.listen 8080
console.log "Server started!"
