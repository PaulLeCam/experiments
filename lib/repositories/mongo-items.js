// Generated by CoffeeScript 1.4.0
var Item, MongoRepository;

MongoRepository = require("../components/data/mongo-repository");

Item = require("../entities/item");

module.exports = new MongoRepository({
  name: "items",
  Entity: Item
});