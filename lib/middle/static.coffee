{readFile} = require 'fs'

module.exports = (req, res, next) -> 
  if res.resolvedPath?
    readFile res.resolvedPath, (err, data) -> res.end data
  next()
