Scheming = sharedRequire 'Scheming'

sharedExport module, ->
  Scheming.create 'User',
    id : {
      type : String
      default : Scheming.uuid
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
            return "Must contain an uppercase character"
      ]
    }
