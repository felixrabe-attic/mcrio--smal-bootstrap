they = it

expect = require('chai').expect

index = require '../'

describe 'smal-bootstrap', ->

  eq = null

  before ->
    eq = (input, expected) ->
      actual = index input
      try
        expect(actual).to.equal expected  # just compares strings, no deep equal needed
      catch err
        err.message = 'not equal'
        err.showDiff = false
        throw err

  it 'should accept empty input', ->
    eq '', '''
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <meta name="description" content="">
          <meta name="author" content="">
          <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

          <title>Bootstrap</title>

          <!-- Bootstrap core CSS -->
          <link href="../../dist/css/bootstrap.min.css" rel="stylesheet">

          <!-- Custom styles for this template -->
          <link href="navbar-static-top.css" rel="stylesheet">

          <!-- Just for debugging purposes. Don't actually copy this line! -->
          <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

          <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
          <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
          <![endif]-->
        </head>
        <body>
          <div class="container">

          </div> <!-- .container -->

          <!-- Bootstrap core JavaScript
          ================================================== -->
          <!-- Placed at the end of the document so the pages load faster -->
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
          <script src="../../dist/js/bootstrap.min.js"></script>
        </body>
      </html>

    '''

  it 'should be able to build examples/navbar-static-top', ->
    eq '''
      // http://getbootstrap.com/examples/navbar-static-top/

      title "Static Top Navbar Example for Bootstrap"

      navbar static
        brand "Project name"              (to "#")

        item "Home"                       (to "#")  active
        item "About"                      (to "#about")
        item "Contact"                    (to "#contact")
        item "Dropdown"
          item "Action"                   (to "#")
          item "Another action"           (to "#")
          item "Something else here"      (to "#")
          divider
          header "Nav header"
          item "Separated link"           (to "#")
          item "One more separated link"  (to "#")

        space
        item "Default"     (to "http://getbootstrap.com/examples/navbar/")
        item "Static top"  (to "http://getbootstrap.com/examples/navbar-static-top/")  active
        item "Fixed top"   (to "http://getbootstrap.com/examples/navbar-fixed-top/")

      jumbotron
        header "Navbar example"
        p "This example is a quick exercise to illustrate how the default, static and fixed to top navbar work. It includes the responsive CSS and HTML, so it also adapts to your viewport and device."
        p "To see the difference between static and fixed top navbars, just scroll."
        button primary "View navbar docs »" (to "http://getbootstrap.com/components/#navbar")

    ''', '''
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <meta name="description" content="">
          <meta name="author" content="">
          <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

          <title>Static Top Navbar Example for Bootstrap</title>

          <!-- Bootstrap core CSS -->
          <link href="../../dist/css/bootstrap.min.css" rel="stylesheet">

          <!-- Custom styles for this template -->
          <link href="navbar-static-top.css" rel="stylesheet">

          <!-- Just for debugging purposes. Don't actually copy this line! -->
          <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

          <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
          <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
          <![endif]-->
        </head>
        <body>
          <div class="navbar navbar-default navbar-static-top" role="navigation">
            <div class="container">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Project name</a>
              </div>
              <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                  <li class="active"><a href="#">Home</a></li>
                  <li><a href="#about">About</a></li>
                  <li><a href="#contact">Contact</a></li>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="#">Action</a></li>
                      <li><a href="#">Another action</a></li>
                      <li><a href="#">Something else here</a></li>
                      <li class="divider"></li>
                      <li class="dropdown-header">Nav header</li>
                      <li><a href="#">Separated link</a></li>
                      <li><a href="#">One more separated link</a></li>
                    </ul>
                  </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                  <li><a href="http://getbootstrap.com/examples/navbar/">Default</a></li>
                  <li class="active"><a href="http://getbootstrap.com/examples/navbar-static-top/">Static top</a></li>
                  <li><a href="http://getbootstrap.com/examples/navbar-fixed-top/">Fixed top</a></li>
                </ul>
              </div><!--/.nav-collapse -->
            </div>
          </div>
          <div class="container">
            <!-- Main component for a primary marketing message or call to action -->
            <div class="jumbotron">
              <h1>Navbar example</h1>
              <p>This example is a quick exercise to illustrate how the default, static and fixed to top navbar work. It includes the responsive CSS and HTML, so it also adapts to your viewport and device.</p>
              <p>To see the difference between static and fixed top navbars, just scroll.</p>
              <p>
                <a class="btn btn-lg btn-primary" href="http://getbootstrap.com/components/#navbar" role="button">View navbar docs »</a>
              </p>
            </div>
          </div> <!-- .container -->

          <!-- Bootstrap core JavaScript
          ================================================== -->
          <!-- Placed at the end of the document so the pages load faster -->
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
          <script src="../../dist/js/bootstrap.min.js"></script>
        </body>
      </html>

    '''

  it 'should be able to build examples/starter-template', ->
    eq '''
      title "Starter Template for Bootstrap"
      stylesheet "starter-template.css"

      navbar inverse
        brand "Project name"              (to "#")

        item "Home"                       (to "#")         active
        item "About"                      (to "#about")
        item "Contact"                    (to "#contact")

      container (around "starter-template")
        header "Bootstrap starter template"
        p (class "lead")
          "Use this document as a way to quickly start any new project."
          br
          " All you get is this text and a mostly barebones HTML document."

    ''', '''
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <meta name="description" content="">
          <meta name="author" content="">
          <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

          <title>Starter Template for Bootstrap</title>

          <!-- Bootstrap core CSS -->
          <link href="../../dist/css/bootstrap.min.css" rel="stylesheet">

          <!-- Custom styles for this template -->
          <link href="starter-template.css" rel="stylesheet">

          <!-- Just for debugging purposes. Don't actually copy this line! -->
          <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

          <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
          <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
          <![endif]-->
        </head>
        <body>
          <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Project name</a>
              </div>
              <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                  <li class="active"><a href="#">Home</a></li>
                  <li><a href="#about">About</a></li>
                  <li><a href="#contact">Contact</a></li>
                </ul>

              </div><!--/.nav-collapse -->
            </div>
          </div>
          <div class="container">
            <div class="starter-template">
              <h1>Bootstrap starter template</h1>
              <p class="lead">
                Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.
              </p>
            </div>
          </div> <!-- .container -->

          <!-- Bootstrap core JavaScript
          ================================================== -->
          <!-- Placed at the end of the document so the pages load faster -->
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
          <script src="../../dist/js/bootstrap.min.js"></script>
        </body>
      </html>

    '''
