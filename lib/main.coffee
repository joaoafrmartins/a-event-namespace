Mixto = require 'mixto'

class AEventNamespace extends Mixto

  extended: () ->

    @options ?= {}

    @options.eventNamespace ?= @eventNamespace

    if namespace = @options.eventNamespace

      eventListeners = {}

      for event, callbacks of @options.eventListeners

        name = "#{event}.#{namespace}"

        eventListeners[name] = callbacks.map (e) ->

          e.name = name

          e.args ?= []

          e.args[0] = name

          return e

      @options.eventListeners = eventListeners

      if emit = @emit

        ns = new RegExp "\\.#{namespace}$"

        @emit = (e, args...) =>

          if e isnt "error" and not e.match ns then e = "#{e}.#{namespace}"

          return emit.apply @, [e].concat args

module.exports = AEventNamespace
