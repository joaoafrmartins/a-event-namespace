describe 'AEventNamespace', () ->

  it 'before', () ->

    kosher.alias 'fixture', kosher.spec.fixtures.emitters

  describe 'methods', () ->

    describe 'extend', () ->

      it 'should be prefix "eventsListeners" on options', () ->

        kosher.alias 'instance', new kosher.fixture.A

          eventNamespace: "namespace"

          eventListeners:

            "event": [
              {
                enable: "on",
                disable: "off",
                name: "event",
                callback: () ->
              }
            ]

        e = "event.namespace"

        kosher.instance.options.eventListeners[e].should.be.Array

        kosher.instance.options.eventListeners[e].length.should.eql 1

        kosher.instance.options.eventListeners[e][0].args[0].should.eql e

    describe 'emit', () ->

      it 'should automatically namespace events', (done) ->

        kosher.alias 'instance', new kosher.fixture.B

          eventNamespace: "namespace",

          callback: () ->

            expect(kosher.instance["event.namespace"]).to.be.ok

            done()

        kosher.instance.emit "event"

      it 'should not namespace the error event', (done) ->

        kosher.alias 'instance', new kosher.fixture.B

          eventNamespace: "namespace",

          callback: () ->

            expect(kosher.instance["error"]).to.be.ok

            done()

        kosher.instance.emit "error"
