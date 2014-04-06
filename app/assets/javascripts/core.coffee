class (window.maven or= {}).Core
  initialized: false

  @instance: ->
    @__instance or= new Core()

  @initialize: ->
    if @instance().initialized
      maven.Logger.error('Core already initialized')
      return

    @instance().__initialize()
    maven.pub('maven.Core.initialized')

  @init_widgets: (parent_container) ->
    _.each window.maven.widgets, (widget_class) ->
      try
        widget_class.init(parent_container)
      catch error
        maven.Logger.error(error)

  @destroy_widgets: (parent_container) ->
    _.each parent_container.find('.js-widget'), (widget_container) ->
      try
        maven.Widget.destroy(widget_container)
      catch error
        maven.Logger.error(error)

  __initialize: ->
    maven.Core.init_widgets()
    $(window).on 'hashchange', -> maven.pub('window.hashchange')
    @initialized = true
