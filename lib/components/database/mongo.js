// Generated by CoffeeScript 1.4.0
var config, db, debug;

debug = require("debug")("app:mongo");

config = require("../../../config").db.mongo;

db = require("monk")(config.host);

module.exports = db;
