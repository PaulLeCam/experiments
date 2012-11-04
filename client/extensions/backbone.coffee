define [
  "core"
  "commandExtension"
  "underscore"
  "backbone"
], (core, command, _, Backbone) ->

  deferred = core.data.deferred

  Events = Backbone.Events
  Events.emit = Events.trigger # Match Aura

  class CacheItem extends Backbone.Model
    defaults:
      refs: {}
      duration: 300

  cacheItems = new Backbone.Collection
    model: CacheItem

  command.register "data.fetch", (dfd, url, attrs, options) ->
    require [url], (Cls) ->
      return dfd.reject() unless Cls
      instance = new Cls attrs, options
      if instance.fromCache then dfd.resolve instance
      else instance.fetch().pipe dfd.resolve, dfd.reject

  # Add cache release function

  constructorCheck = (attrs, options) ->
    # Check if present in cache
    if attrs.rid and cacheItem = cacheItems.get attrs.rid
      self = cacheItem.get "data"
      self.set attrs # Update with new attributes
      self.fromCache = cacheItem.get "update"

      cacheItem.set "update", new Date()

      # If cache options, add to cacheItem
      if options.cache and options.cache.ref
        refs = cacheItem.get "refs"
        duration = options.cache.duration ? cacheItem.get "duration"
        refs[options.cache.ref] =
          if duration then duration + new Date()
          else on
        cacheItem.set "refs", refs

      self # Return instance
    else no # Not in cache

  constructorCreate = (self, attrs, options) ->
    cacheAttrs =
      id: attrs.rid ? _.uniqueId "r"
      data: self
      update: new Date()
      refs: {}

    if options.cache and options.cache.ref
      duration = options.cache.duration ? options.cache.defaultDuration
      cacheAttrs.refs[options.cache.ref] =
        if duration? then duration + new Date
        else on
      cacheAttrs.duration = options.cache.defaultDuration if options.cache.defaultDuration?

    cacheItems.add new CacheItem cacheAttrs

  class Model extends Backbone.Model

    constructor: (attrs = {}, options = {}) ->
      return attrs if attrs instanceof Model
      return self if self = constructorCheck attrs, options

      super attrs
      constructorCreate @, attrs, options

  class Collection extends Backbone.Collection

    constructor: (attrs = {}, options = {}) ->
      return attrs if attrs instanceof Collection
      return self if self = constructorCheck attrs, options

      super attrs
      constructorCreate @, attrs, options

  {Router, View} = Backbone
  {Events, Router, View, Model, Collection}
