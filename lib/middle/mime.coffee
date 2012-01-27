{lookup} = require 'mime'

module.exports = (req, res, path) ->
  if path?
    res.writeHead 200, "Content-Type": lookup path
