they = it

expect = require('chai').expect

index = require '../'

describe 'smal-bootstrap', ->

  eq = null

  before ->
    eq = (input, expected) ->
      expect(index input).to.equal expected  # just compares strings, no deep equal needed

  it 'should accept empty input', ->
    eq '', '''
      <!DOCTYPE html>
      <html lang="en">
        <body>
          <div class="container">


          </div> <!-- /container -->

          <!-- Bootstrap core JavaScript
          ================================================== -->
          <!-- Placed at the end of the document so the pages load faster -->
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
          <script src="../../dist/js/bootstrap.min.js"></script>
        </body>
      </html>

    '''
