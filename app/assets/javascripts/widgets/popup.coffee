class maven.widgets.Popup extends maven.Widget
  @SELECTOR: '.Popup'

  initialize: ->
    @identifier = @$container.data('identifier')

    # Binds on other popups
    maven.sub("popup.show", @autoclose)

    # Binds on button click
    maven.sub("popup.toggle.#{@identifier}", @toggle)

    # Move into proper HTML position
    @$container.appendTo($('body'))

  # Closes when other popup gets opened
  autoclose: (e, widget) => @hide() if widget != @

  # Toggles visibility on trigger click
  toggle: => if @$container.is(':visible') then @hide() else @show()

  autoplace: =>
    @$container.css('margin-left', "-#{@width()/2}px")
    @$container.css('margin-top', "-#{@height()/2}px")

  show: =>
    # Close other popups
    maven.pub("popup.show", [@]);

    # Show this popup
    @$container.show()
    @autoplace()

    # Show overlay
    maven.pub("popup.show.overlay");
    @$container.find('input:first').focus()

  hide: =>
    @$container.hide()
    maven.pub("popup.hide");

  width: -> @$container.outerWidth()
  height: -> @$container.outerHeight()
