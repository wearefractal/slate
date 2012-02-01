{EventEmitter} = require 'events'
http = require 'http'
https = require 'https'
{readdirSync} = require 'fs'
{basename, extname, join} = require 'path'
{parse} = require 'url'
{lookupFile} = require './util'
require './httpExtend'

class HttpServer extends EventEmitter
  constructor: (@config) ->
    @loadDefaults()
    @on 'request', (req, res) => 
      stack = (val for key,val of @config.get('middle'))
      next = => 
        ware = stack.shift()
        return unless ware?
        if ware.enabled
          ware.fn req, res, next, @config
        else
          next()
      next()
      return
      
  enable: (args...) -> @config.middle[name]?.enabled = true for name in args
  disable: (args...) -> @config.middle[name]?.enabled = false for name in args
  
  engine: (ext, obj, data, options) -> @config.engines[ext] = compile: obj, data: data, options: options
  use: (name, fn, args...) -> @config.middle[name] = fn: fn, args: args
  
  listen: (@port, @host) ->
    if @config.get 'https'
      serv = https.createServer @handleRequest
    else
      serv = http.createServer @handleRequest
    serv.listen @port, @host
    @emit 'ready'
    return serv
    
  handleRequest: (req, res) =>
    return unless req? and res?
    pathname = parse(req.url).pathname
    path = lookupFile pathname, @config
    req.resolvedPath = path
    res.setHeader 'X-Powered-By', 'Slate'
    @emit 'request', req, res
  
  loadDefaults: ->
    middleDir = join __dirname + '/middle/'
    incl = readdirSync middleDir
    for file in incl
      absolute = join middleDir, file
      if require.resolve absolute
        @use basename(file, extname(file)), require(absolute), null
  
module.exports = HttpServer
