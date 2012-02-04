module.exports = (req, res, next, config) ->
  if req.method is 'OPTIONS'
    res.writeHeader 'Access-Control-Allow-Origin', '*'
    res.writeHeader 'Access-Control-Allow-Headers', '*'
  next()
