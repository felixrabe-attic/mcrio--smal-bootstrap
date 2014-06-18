_ = require 'lodash'
smal = require 'smal'

String::trimRight ?= -> @replace /\s+$/, ''

h = htmlEscape = do ->
  # Based on https://github.com/wycats/handlebars.js/blob/49fcf10de21b89c504d641e72ce6c31c2feaed8f/lib/handlebars/utils.js

  escape =
    "&": "&amp;"
    "<": "&lt;"
    ">": "&gt;"
    '"': "&quot;"
    "'": "&#x27;"
    "`": "&#x60;"

  badChars = /[&<>"'`]/g
  possible = /[&<>"'`]/

  escChar = (char) -> escape[char]

  return (string) ->
    string = '' + string
    return string unless possible.test string
    string.replace badChars, escChar

beginningOfLine = /^(?=.)/mg

ind = (indent, string) ->
  string.replace beginningOfLine, indent

indentedJoin = (array, extraIndent = '') ->
  _.map array, ([indent, text]) ->
    text.replace beginningOfLine, indent + extraIndent
  .join('\n') + '\n'

run = (fn, dom, name = undefined, data = undefined) ->
  ob = fn name, data
  for node in dom
    switch node.length
      when 1  # text
        [nodeName, nodeDom] = ['__TEXT__', []]
        [nodeData] = node
      when 2  # node
        [nodeName, nodeDom] = node
        [nodeData] = [undefined]
      else
        throw new Error 'Invalid node'
    nodeFn = ob[nodeName] or ob.__UNKNOWN__
    run nodeFn, nodeDom, nodeName, nodeData if nodeFn
  endFn = ob.__END__
  endFn() if endFn

bootstrapConversion = ->
  html = []
  html.push ['', """
    <!DOCTYPE html>
    <html lang="en">
  """]

  navbarInsideContainer = true
  navbar = ''

  title = 'Bootstrap'

  headEnded = false
  headEnd = ->
    return if headEnded
    headEnded = true
    html.push ['  ', """
      <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

        <title>#{h title}</title>

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
    """]

  pageContent = ''

  title: ->
    __TEXT__: (name, data) -> title = data

  navbar: ->
    headEnd()
    navbarClass = 'navbar navbar-default'
    brand = ''
    menuLeft = []
    menuRight = []
    targetMenu = menuLeft

    static: ->
      navbarInsideContainer = false
      navbarClass = 'navbar navbar-default navbar-static-top'

    fixed: ->
      navbarInsideContainer = false
      navbarClass = 'navbar navbar-default navbar-fixed-top'

    brand: ->
      text = ''
      to = ''

      __TEXT__: (name, data) -> text = data
      to: -> __TEXT__: (name, data) -> to = data
      __END__: ->
        brand = """<a class="navbar-brand" href="#{h to}">#{h text}</a>"""

    item: ->
      text = ''
      to = '#'
      isActive = false
      subItems = []

      __TEXT__: (name, data) -> text = data
      to: -> __TEXT__: (name, data) -> to = data
      active: -> isActive = true

      item: ->
        text_2 = ''
        to_2 = '#'
        isActive_2 = false

        __TEXT__: (name, data) -> text_2 = data
        to: -> __TEXT__: (name, data) -> to_2 = data
        active: -> isActive_2 = true
        __END__: ->
          subItems.push ['', """
            <li#{if isActive_2 then ' class="active"' else ''}><a href="#{h to_2}">#{h text_2}</a></li>
          """]

      divider: ->
        subItems.push ['', """<li class="divider"></li>"""]

      header: ->
        text_2 = ''

        __TEXT__: (name, data) -> text_2 = data
        __END__: ->
          subItems.push ['', """
            <li class="dropdown-header">#{h text_2}</li>
          """]

      __END__: ->
        if subItems.length > 0
          targetMenu.push ['', """
            <li class="dropdown#{if isActive then ' active' else ''}">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">#{h text} <b class="caret"></b></a>
              <ul class="dropdown-menu">
                #{indentedJoin(subItems, '    ').trim()}
              </ul>
            </li>
          """]
        else
          targetMenu.push ['', """
            <li#{if isActive then ' class="active"' else ''}><a href="#{h to}">#{h text}</a></li>
          """]

    space: ->
      targetMenu = menuRight

    __END__: ->
      menuLeft = if menuLeft.length > 0
        """
          <ul class="nav navbar-nav">
            #{indentedJoin(menuLeft, '  ').trim()}
          </ul>
        """
      else
        ''

      menuRight = if menuRight.length > 0
        """
          <ul class="nav navbar-nav navbar-right">
            #{indentedJoin(menuRight, '  ').trim()}
          </ul>
        """
      else
        ''

      navbar = """
        <div class="#{h navbarClass}" role="navigation">
          <div class="#{if navbarInsideContainer then "container-fluid" else "container"}">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              #{ind('      ', brand).trim()}
            </div>
            <div class="navbar-collapse collapse">
              #{ind('      ', menuLeft).trim()}
              #{ind('      ', menuRight).trim()}
            </div><!--/.nav-collapse -->
          </div>
        </div>
      """

  jumbotron: ->
    headEnd()

    jumbotron = []

    jumbotron.push ['', """
      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
    """]

    header: ->
      text = null
      __TEXT__: (name, data) -> text = data
      __END__: -> jumbotron.push ['  ', "<h1>#{h text}</h1>"]

    p: ->
      text = null
      __TEXT__: (name, data) -> text = data
      __END__: -> jumbotron.push ['  ', "<p>#{h text}</p>"]

    button: ->
      type = 'default'
      text = null
      to = ''

      primary: -> type = 'primary'
      __TEXT__: (name, data) -> text = data
      to: -> __TEXT__: (name, data) -> to = data
      __END__: ->
        jumbotron.push ['  ', """
          <p>
            <a class="btn btn-lg btn-#{type}" href="#{h to}" role="button">#{h text}</a>
          </p>
        """]

    __END__: ->
      jumbotron.push ['', """
        </div>
      """]
      pageContent = indentedJoin jumbotron

  __END__: ->
    headEnd()
    html.push ['  ', """
      <body>
    """]

    containerStart = """
      <div class="container">
    """

    if navbarInsideContainer
      html.push ['    ', containerStart]
      html.push ['      ', navbar]
    else
      html.push ['    ', navbar]
      html.push ['    ', containerStart]

    html.push ['      ', pageContent.trimRight()]

    html.push ['    ', """
      </div> <!-- .container -->
    """]

    html.push ['    ', """

      <!-- Bootstrap core JavaScript
      ================================================== -->
      <!-- Placed at the end of the document so the pages load faster -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
      <script src="../../dist/js/bootstrap.min.js"></script>
    """]

    html.push ['  ', """
      </body>
    """]

    html.push ['', """
      </html>
    """]

    return indentedJoin html

module.exports = (input) ->
  run bootstrapConversion, smal.Parser().parse(input)
