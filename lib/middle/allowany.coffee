module.exports = (req, res, next, config) ->
  if req.method is 'OPTIONS'
    res.setHeader 'Access-Control-Allow-Origin', '*'
    res.setHeader 'Access-Control-Allow-Headers', '*'
    res.setHeader 'Access-Control-Allow-Methods', '*'
  next()
