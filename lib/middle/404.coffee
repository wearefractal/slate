module.exports = (req, res, path) -> 
  res.end '404 - Not found' unless path?
