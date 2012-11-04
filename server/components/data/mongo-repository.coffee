Repository = require "./repository"
debug = require("debug") "app:repository:mongo"
mongo = require "../database/mongo"

class MongoRepository extends Repository

  constructor: (data = {}) ->
    super data
    @col = mongo.get @name

  getById: (id, next) ->
    @col.findById(id)
      .error(next)
      .success (doc) =>
        if doc then next null, @export @entity doc
        else next null, false

  getOne: (query = {}, next) ->
    @col.findOne(query)
      .error(next)
      .success (doc) =>
        if doc then next null, @export @entity doc
        else next null, no

  getAll: (query = {}, next) ->
    @col.find(query)
      .error(next)
      .success (docs) =>
        if docs
          res = (@export @entity doc for doc in docs)
          next null, res
        else next null, no

  createOne: (entity, next) ->
    @col.insert(@import entity)
      .error(next)
      .success (doc) =>
        next null, @export @entity doc

  updateOne: (entity, next) ->
    @col.updateById(entity._id, @import entity)
      .error(next)
      .success (doc) =>
        next null, @export @entity doc

  saveOne: (entity, next) ->
    if entity._id then @updateOne entity, next
    else @createOne entity, next

  deleteOne: (entity, next) ->
    @col.remove(_id: entity._id)
      .error(next)
      .success =>
        next null

module.exports = MongoRepository
