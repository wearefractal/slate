module.exports = (req, res, next, config) ->
  if req.resolvedPath? and req.isModule
    try
      mod = require req.resolvedPath
      mod req, res, next, config
    catch err # not a module
      throw err
      next()
  else
    next()
