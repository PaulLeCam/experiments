express = require "express"
debug = require("debug") "app:routes"
app = express()

app.configure ->
  @set "views", "#{ __dirname }/../../lib/views"
  @use "/items", require "./items"

app.get "/", (req, res) ->
  res.render "home"

app.get "*", (req, res) ->
  res.render "errors/404"

debug "defined"

module.exports = app
