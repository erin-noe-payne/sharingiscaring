Scheming = sharedRequire 'Scheming'
moment = sharedRequire 'moment'

Scheming.TYPES.Date.identifier = moment.isMoment
Scheming.TYPES.Date.parser = moment

return {}