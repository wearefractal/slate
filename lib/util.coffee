{join, existsSync, readdirSync, dirname, basename, extname} = require 'path'
module.exports =  
  lookupFile: (lpath, engines, root) ->
    path = join root, lpath, 'index.html'
    return path if existsSync path
    path = join root, lpath, 'index.htm'
    return path if existsSync path
    path = join root, lpath
    return path if existsSync path
    
    # Check our engines
    if engines?
      keys = Object.keys engines
      if keys.length > 0
        for ext in keys
          path = join root, dirname(lpath), basename(lpath, ext), 'index' + ext
          return path if existsSync path
    return
