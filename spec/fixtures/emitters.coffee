{ EventEmitter } = require 'events'

kosher.alias 'AEventNamespace'

class AEmitter extends EventEmitter

  constructor: (@options={}) ->

    super

    kosher.AEventNamespace.extend @

class A extends AEmitter

class B extends AEmitter

  constructor: (@options={}) ->

    super @options

    @on "event.namespace", () =>

      @["event.namespace"] = true

      @options.callback()

    @on "error", () =>

      @["error"] = true

      @options.callback()

module.exports =

  "A": A

  "B": B
