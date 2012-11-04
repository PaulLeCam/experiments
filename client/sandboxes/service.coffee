define [
  "core"
  "commandExtension"
  "httpExtension"
], (core, command, http) ->

  util: core.util
  data: core.data
  on: (channel, cb) -> core.on channel, "service", cb, @
  emit: -> core.emit.apply @, arguments
  register: command.register
  request: command.request
  http: http
