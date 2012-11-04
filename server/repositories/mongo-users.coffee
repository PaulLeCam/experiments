MongoRepository = require "../components/data/mongo-repository"
User = require "../entities/user"

module.exports = new MongoRepository
  name: "users"
  Entity: User
