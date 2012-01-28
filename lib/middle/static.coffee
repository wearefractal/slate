{readFile} = require 'fs'
{extname} = require 'path'

module.exports = (req, res, next, config) ->
  if req.resolvedPath?
    readFile req.resolvedPath, (err, data) -> 
      return res.deny 500 if err? or !data
      engines = config.get 'engines'
      ext = extname(req.resolvedPath)[1..]
      eng = engines[ext]
      data = String data
      if eng?
        data = eng.compile data, eng.data, eng.options
      res.end data
  next()