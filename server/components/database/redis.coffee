redis = require "redis"
debug = require("debug") "app:redis"
config = require("../../../config").db.redis

client = redis.createClient()
pubsub = redis.createClient()
prefix = (key) -> "#{ config.prefix }:#{ key }"

client.on "error", debug
pubsub.on "error", debug

module.exports = {client, pubsub, prefix}
