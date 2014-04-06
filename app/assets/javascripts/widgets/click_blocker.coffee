# Prevents a page from any clicks before core is initialized
class maven.widgets.ClickBlocker extends maven.Widget
  @SELECTOR: '#ClickBlocker'

  initialize: ->
    maven.sub('maven.Core.initialized', @disable)

  disable: =>
    @$container.hide()

  enable: =>
    @$container.show()
