# Toggles popup visibility
class maven.widgets.PopupTrigger extends maven.Widget
  @SELECTOR: '.PopupTrigger'

  initialize: ->
    @target = @$container.data('target')
    @$container.click @on_click

  on_click: =>
    maven.pub("popup.toggle.#{@target}")
    false
