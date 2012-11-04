{Resource} = require "delorean"
debug = require("debug") "app:repository"

class Repository extends Resource

  constructor: (data = {}) ->
    debug "Expecting name and Entity parameters" unless data.name and data.Entity
    super data

  import: (entity) -> entity

  export: (entity) -> entity

  entity: (doc) -> new @Entity doc

module.exports = Repository
