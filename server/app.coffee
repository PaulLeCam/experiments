config = require("../config").app
express = require "express"
RedisStore = require("connect-redis") express
debug = require("debug") "app"
redis = require "./components/database/redis"
auth = require "./components/security/auth"
app = express()

app.engine "jade", require("jade").__express

app.configure ->
  @set "view engine", "jade"
  @set "views", "#{ __dirname }/../lib/views"

  @use express.logger "dev"
  @use express.compress()
  @use express.favicon()
  @use express.static "#{ __dirname }/../www"
  @use express.cookieParser "SGSDGHE4Z92364234YE7857354"
  @use express.session
    store: new RedisStore
      client: redis.client
      prefix: redis.prefix "sess:"
      ttl: 3600
    secret: "TDIUREQT496457036TQZRGQ"
  @use express.bodyParser()
  @use express.csrf()

  @use auth.middleware() # Authentication middleware, everyauth
  @use require "./routes"

  @use express.errorHandler()

port = config.port ? 3000
app.listen port
debug "listening on port %s", port
