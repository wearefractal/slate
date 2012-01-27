{join, existsSync, readdirSync, dirname, basename, extname} = require 'path'
module.exports =  
  lookupFile: (lpath, config) ->
    root = config.get 'root'
    engines = config.get 'engines'
    lpath = join root, lpath
    
    # Find folder index
    if lpath.charAt(lpath.length-1) is '/'
      path = join lpath, 'index.html'
      return path if existsSync path
      path = join lpath, 'index.htm'
      return path if existsSync path
      
      # Check custom engines
      for key in Object.keys engines
        path = join lpath, 'index.' + key
        return path if existsSync path
    else # Specific file
      return lpath if existsSync path
    return
