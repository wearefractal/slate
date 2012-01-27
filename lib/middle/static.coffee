{readFile} = require 'fs'

module.exports = (req, res, path) -> 
  if path?
    readFile path, (err, data) -> res.end data
