Scheming = sharedRequire 'Scheming'

uuid = ->
  now = Date.now()
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
    r = (now + Math.random() * 16) % 16 | 0
    now = Math.floor now / 16
    ((if c is "x" then r else (r & 0x7 | 0x8))).toString 16

sharedExport module, ->
  Scheming.create 'User',
    id : {
      type : String
      default : -> uuid()
    }
    name : {
      type : String
      required : true
      validate : (val) ->
        if val.trim().length == 0
          return "Name is required"
        else return true
    }
    birthday : {
      type :Date
    }
    secret : {
      type : String
      required : true
      validate : [
        (val) ->
          if val.length > 4
            return true
          else
            return "Must be greater than 4 characters"
        (val) ->
          if val.match /[A-Z]/
            return true
          else
            return "Must contain an upercase character"
      ]
    }
