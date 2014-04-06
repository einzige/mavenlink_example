# Generally used for popups
class maven.widgets.Overlay extends maven.Widget
  @SELECTOR: '.Overlay'

  @instance: ->
    maven.widgets.Overlay.__instance ?= new maven.widgets.Overlay($(@SELECTOR))

  initialize: ->
    unless maven.widgets.Overlay.__instance
      maven.widgets.Overlay.__instance = @
      maven.sub('popup.show.overlay', @show)
      maven.sub('popup.hide.overlay', @hide)

  show: => @$container.show()
  hide: => @$container.hide()
