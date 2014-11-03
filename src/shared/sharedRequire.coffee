
isNode = typeof exports != 'undefined' && typeof module != 'undefined' && module.exports
root = if isNode then global else window

if !isNode
  root.module = undefined

root.sharedRequire = (name) ->
  if isNode
    return require name
  else
    return window[name]

root.sharedExport = (module, fn) ->
  if isNode
    module.exports = fn
  else
    fn()