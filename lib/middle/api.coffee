module.exports = (req, res, next, config) ->
  if req.resolvedPath?
    try
      mod = require req.resolvedPath
      mod req, res, next, config
      req.isModule = true
    catch err # not a module
      next()
  else
    next()
