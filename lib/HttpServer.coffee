{EventEmitter} = require 'events'
http = require 'http'
https = require 'https'
{readdirSync} = require 'fs'
{basename, extname, join} = require 'path'
{parse} = require 'url'
{lookupFile} = require './util'

class HttpServer extends EventEmitter
  constructor: ->
    @loadDefaults()
    @on 'request', (req, res, path) => 
      for key, val of @middle
        if val.enabled
          val.fn req, res, path
      return
      
  enable: (args...) -> @middle[name]?.enabled = true for name in args
  disable: (args...) -> @middle[name]?.enabled = false for name in args
  
  engine: (ext, fn, args...) -> @engines[ext] = fn: fn, args: args
  engines: {}
  use: (name, fn, args...) -> @middle[name] = fn: fn, args: args
  middle: {}
  
  listen: (@port, @host, @config) ->
    if @config.get 'https'
      serv = https.createServer @handleRequest
    else
      serv = http.createServer @handleRequest
    serv.listen @port, @host
    return serv
    
  handleRequest: (req, res) =>
    return unless req? and res?
    pathname = parse(req.url).pathname
    path = lookupFile pathname, @engines, @config.get 'root'
    @emit 'request', req, res, path
  
  loadDefaults: ->
    middleDir = join __dirname + '/middle/'
    incl = readdirSync middleDir
    for file in incl
      absolute = join middleDir, file
      if require.resolve absolute
        @use basename(file, extname(file)), require(absolute), null
  
module.exports = HttpServer
