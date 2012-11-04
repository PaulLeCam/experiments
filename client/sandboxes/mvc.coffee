define [
  "core"
  "backboneExtension"
  "commandExtension"
  "handlebarsExtension"
  "httpExtension"
], (core, backbone, command, handlebars, http) ->

  util: core.util
  data: core.data
  on: (channel, cb) -> core.on channel, "mvc", cb, @
  emit: -> core.emit.apply @, arguments
  start: -> core.start.apply @, arguments
  stop: -> core.stop.apply @, arguments
  register: command.register
  request: command.request
  mvc:
    Model: backbone.Model
    Collection: backbone.Collection
    View: backbone.View
    Events: backbone.Events
  template: handlebars
  http: http
