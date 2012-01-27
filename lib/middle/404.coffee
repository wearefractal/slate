module.exports = (req, res, next) -> 
  if res.resolvedPath?
    next()
  else
    res.end '404 - Not found'
