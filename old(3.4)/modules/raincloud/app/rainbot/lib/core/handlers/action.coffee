class Action
  constructor: (responseHandler, commandHandler) ->
    @commandHandler = commandHandler
    @responseHandler = responseHandler

  setResponseProperties: (properties) ->
    @responseHandler.setProperties(properties)

  triggered: (action, callback) ->
    if action.trigger @responseHandler.properties
      return callback(true)

  handle: (action, callback) ->
    if action.trigger @responseHandler.properties
      @fireTrigger(action)
    callback(null)

  fireTrigger: (trigger) ->
    if !trigger then return
    @responseHandler.reset()
    self = this
    action = trigger.action @responseHandler, () ->
      self.responseHandler.respond()

  fireCommand: (commandText) ->
    if !commandText then return
    commands = @commandHandler.getCommands(commandText)
    self = this
    @commandHandler.run commands, @responseHandler, (lastAction) ->
      self.responseHandler.respond()

module.exports = Action