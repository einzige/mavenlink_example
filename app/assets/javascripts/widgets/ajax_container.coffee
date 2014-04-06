# Renders remote URL into html container
# If a link is clicked - container acts as IFrame
#
# @data url [String, null] url to load on widget initialized.
class maven.widgets.AjaxContainer extends maven.Widget
  @SELECTOR: '.AjaxContainer'

  initialize: ->
    @url = @$container.data('url')
    @bind_links()
    @render()

  render: ->
    @render_path(@url) if @url

  link_clicked: (e) =>
    window.location.hash = $(e.currentTarget).attr('href')
    return false

  render_path: (request_path) ->
    @$container.addClass('pending')
    callbacks = {success: @render_page, replace: @replace_page, append: @append_page, prepend: @prepend_page, after: @on_response_received}
    maven.Ajax.get(request_path, @request_params(), callbacks)

  append_page: (response) =>
    maven.append_html(@$container, response['html'])

  prepend_page: (response) =>
    maven.prepend_html(@$container, response['html'])

  replace_page: (response) =>
    maven.replace_container(@$container, response['html'])

  render_page: (response) =>
    maven.replace_html(@$container, response['html'])

  on_response_received: (response) =>
    @bind_links()
    @$container.removeClass('pending')

  request_params: -> {}

  bind_links: ->
    @$container.find('a').click @link_clicked
