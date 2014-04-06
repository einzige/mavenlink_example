maven.widgets or= {}

class maven.Widget
  @instances: []
  @SELECTOR: null

  @init: (parent_container = $('body')) ->
    return unless @SELECTOR

    widget_class = @
    parent_container.find(widget_class.SELECTOR).not('.js-widget').each (index, container) ->
      new widget_class($(container))

  @destroy: (widget_container) ->
    $widget_container = $(widget_container)
    widget = $widget_container.data('js-widget')
    return unless widget

    window.maven.Widget.instances = _.without(window.maven.Widget.instances, widget)
    widget.destroy()
    delete $widget_container.data('js-widget')
    $widget_container.data('js-widget', null)

  @highlight_all:   -> $('.js-widget').addClass('js-highlight')
  @dehighlight_all: -> $('.js-widget').removeClass('js-highlight')

  constructor: (container) ->
    if container.hasClass('js-widget')
      maven.Logger.error("Widget: #{@class_name()} already initialized")
      return

    @$container = container

    @initialize()

    @$container.addClass('js-widget').data('js-widget', @)
    maven.Logger.message("Widget: #{@class_name()} initialized")

    maven.Widget.instances.push(@)

  class_name: -> @.__proto__.constructor.name

  initialize: ->
    # To be redeclared in inherited classes

  destroy: ->
    @$container.unbind()
    @$container.removeClass('js-widget')
    maven.Logger.message("Widget: #{@class_name()} destroying")
