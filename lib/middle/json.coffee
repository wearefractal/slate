module.exports = (req, res, next) ->
  return next() if req.parsedJSON
  return next() if "GET" is req.method or "HEAD" is req.method
  return next() unless "application/json" is req.mime()
  req.body = req.body or {}
  req.parsedJSON = true
  
  buf = ""
  req.setEncoding "utf8"
  req.on "data", (chunk) -> buf += chunk

  req.on "end", ->
    try
      req.body = (if buf.length then JSON.parse(buf) else {})
      next()
    catch err
      res.end()
