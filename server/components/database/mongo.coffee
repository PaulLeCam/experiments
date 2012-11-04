debug = require("debug") "app:mongo"
config = require("../../../config").db.mongo
db = require("monk") config.host

module.exports = db
