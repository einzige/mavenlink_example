#= require ./popup

# Shows remote URL in the popup
# @data url [String]
class maven.widgets.AjaxPopup extends maven.widgets.Popup
  @SELECTOR: '.AjaxPopup'

  initialize: ->
    super
    @url = @$container.data('url')

  show: =>
    super
    maven.Ajax.get(@url, {}, {success: @on_response_received})

  on_response_received: (response) =>
    @$container.css('max-height', "#{$(window).height() - 30}px")
    @$container.css('max-width', "#{$(window).width() - 30}px")
    maven.replace_html(@$container, response['html'])
    @autoplace()
    @$container.find('img').load(@autoplace)
