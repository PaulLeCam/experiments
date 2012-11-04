express = require "express"
debug = require("debug") "app:routes:items"
items = require "../repositories/mongo-items"
app = express()

app.param "id", (req, res, next, id) ->
  items.getById {id}, (err, resource) ->
    if err then res.send 500
    else if resource
      req.resource = resource
      next()
    else res.send 404

# List all
app.get "/", (req, res) ->
  query =
    limit: req.query.limit ? 20
    start: req.query.start ? 0
  items.getAll query, (err, entities) ->
    if err
      debug err
      res.send 500
    else res.json entities

# Get one by ID
app.get "/:id", (req, res) ->
  res.json req.resource

# Create one
app.post "/", (req, res) ->
  items.createOne req.body, (err, entity) ->
    if err
      debug err
      res.send 500
    else res.json entity

# Update one by ID
app.put "/:id", (req, res) ->
  items.updateById req.body, (err, entity) ->
    if err
      debug err
      res.send 500
    else res.json entity

# Delete one by ID
app.del "/:id", (req, res) ->
  items.deleteOne _id: req.params.id, (err) ->
    if err
      debug err
      res.send 500
    else res.send 200

debug "defined"

module.exports = app
