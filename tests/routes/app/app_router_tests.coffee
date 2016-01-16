require('rootpath')()
chai = require('chai')
expect = chai.expect

describe 'Route Device - Custom Data', () ->

  it 'it should be 9', (done) ->
    expect(4+5).to.equal(9)
    done()
