{readFile} = require 'fs'
{extname} = require 'path'

module.exports = (req, res, next, config) ->
  if req.resolvedPath?
    readFile req.resolvedPath, (err, data) -> 
      return if err?
      engines = config.get 'engines'
      ext = extname(req.resolvedPath)[1..]
      eng = engines[ext]
      data = String data
      if eng?
        if typeof eng.compile is 'function'
          compile = eng.compiler
        else
          compile = eng.compiler.compile
        data = compile data, eng.args.options
        data = data.render eng.args.data if typeof data?.render is 'function' # Hogan
        data = data eng.args.data if typeof data is 'function' # Jade
      res.end data
  next()
