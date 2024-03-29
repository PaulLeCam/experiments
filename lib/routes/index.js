// Generated by CoffeeScript 1.4.0
var app, debug, express;

express = require("express");

debug = require("debug")("app:routes");

app = express();

app.configure(function() {
  this.set("views", "" + __dirname + "/../../lib/views");
  return this.use("/items", require("./items"));
});

app.get("/", function(req, res) {
  return res.render("home");
});

app.get("*", function(req, res) {
  return res.render("errors/404");
});

debug("defined");

module.exports = app;
