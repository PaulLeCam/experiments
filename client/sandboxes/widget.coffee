define [
  "core"
  "jquery"
  "commandExtension"
  "backboneExtension"
  "handlebarsExtension"
], (core, $, command, backbone, handlebars) ->

  util: core.util
  dom:
    find: core.dom.find
    data: core.dom.data
    ready: (cb) -> $ -> cb()
  data: core.data
  events: core.events
  on: (channel, cb) -> core.on channel, "widget", cb, @
  emit: -> core.emit.apply @, arguments
  start: -> core.start.apply @, arguments
  stop: -> core.stop.apply @, arguments
  request: command.request
  mvc:
    View: backbone.View
    Events: backbone.Events
  template: handlebars
