# Renders remote URL into html container
# If a link is clicked - container acts as IFrame
#
# @data url [String, null] url to load on widget initialized.
class maven.widgets.ApplicationContainer extends maven.Widget
  @SELECTOR: '.ApplicationContainer'

  initialize: ->
    @bind_links()
    maven.sub('window.hashchange', @location_changed)

    if _.isEmpty(window.location.hash)
      window.location.hash = @$container.data('url')
    else
      @location_changed()

  url: -> window.location.hash.replace('#', '')

  location_changed: =>
    @render_path(@url())

  link_clicked: (e) =>
    window.location.hash = $(e.currentTarget).attr('href')
    return false

  render_path: (request_path) ->
    @$container.addClass('pending')
    maven.Ajax.get(request_path, {}, {success: @render_page, after: @on_response_received})

  render_page: (response) =>
    maven.replace_html(@$container, response['html'])

  on_response_received: (response) =>
    @$container.removeClass('pending')
    @bind_links()

  bind_links: ->
    @$container.find('a').click @link_clicked
