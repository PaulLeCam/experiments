// Generated by CoffeeScript 1.4.0
var Entity, Resource, debug, _, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

_ref = require("delorean"), _ = _ref._, Resource = _ref.Resource;

debug = require("debug")("app:entity");

Entity = (function(_super) {

  __extends(Entity, _super);

  function Entity() {
    return Entity.__super__.constructor.apply(this, arguments);
  }

  return Entity;

})(Resource);

module.exports = Entity;