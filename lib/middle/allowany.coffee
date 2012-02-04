module.exports = (req, res, next, config) ->
  if req.method is 'OPTIONS'
    res.writeHead 200,
      'Access-Control-Allow-Origin': req.headers.origin,
      'Access-Control-Allow-Headers': req.headers['access-control-request-headers'],
      'Access-Control-Allow-Methods': req.headers['access-control-request-method']
    return res.end()
  next()