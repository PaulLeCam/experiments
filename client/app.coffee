require.config
  baseUrl: "/"
  shim:
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"
    handlebars:
      exports: "Handlebars"
    bootstrap:
      deps: ["jquery"]
  paths:
    # RequireJS plugins
    text: "lib/require/text"
    async: "lib/require/async"
    propertyParser: "lib/require/propertyParser"

    # Aura deps
    jquery: "lib/jquery"
    underscore: "lib/lodash"
    backbone: "lib/backbone"
    # Aura core and extensions
    core: "lib/aura/core"
    backboneExtension: "extensions/backbone"
    commandExtension: "extensions/command"
    handlebarsExtension: "extensions/handlebars"
    httpExtension: "extensions/http"
    # Aura sandboxes
    mvcSandbox: "sandboxes/mvc"
    serviceSandbox: "sandboxes/service"
    widgetSandbox: "sandboxes/widget"

    # App libs
    handlebars: "lib/handlebars"
    bootstrap: "lib/bootstrap"

require.aura =
  baseUrl: "/"
  shim:
    dom:
      exports: "$"
      deps: ["jquery"]
  paths:
    aura_base: "lib/aura/base"
    dom: "lib/aura/dom"
    core: "lib/aura/core"

require.config require.aura

require [
  "widgetSandbox"
  "bootstrap"
], (sandbox) ->

  sandbox.dom.ready ->
    console.log "DOM ready"
