{lookup} = require 'mime'
{extname} = require 'path'

module.exports = (req, res, next, config) ->
  if req.resolvedPath?
    engines = config.get 'engines'
    ext = extname(req.resolvedPath)[1..]
    if engines[ext]?
      res.writeHead 200, "Content-Type": "text/html"
    else
      res.writeHead 200, "Content-Type": lookup req.resolvedPath
  next()
