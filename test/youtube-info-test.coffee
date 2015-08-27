chai = require "chai"
sinon = require "sinon"
chai.use require "sinon-chai"

expect = chai.expect

describe "youtube-info", ->
    beforeEach ->
        @robot =
            hear: sinon.spy()

        require("../src/youtube-info")(@robot)

    it "registers a hear listener", ->
        expect(@robot.hear).to.have.been.calledWith(/(https?:\/\/(www|gaming)\.youtube\.com\/watch\?.+?)(?:\s|$)/i)
        expect(@robot.hear).to.have.been.calledWith(/(https?:\/\/youtu\.be\/)([a-z0-9\-_]+)/i)
