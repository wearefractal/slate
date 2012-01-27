{lookup} = require 'mime'

module.exports = (req, res, next) ->
  if res.resolvedPath?
    res.writeHead 200, "Content-Type": lookup res.resolvedPath
  next()
