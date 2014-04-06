# Acts as a simple form
# Posts data attributes to the URL defined by link href
class maven.widgets.AjaxFormLink extends maven.Widget
  @SELECTOR: '.AjaxFormLink'

  initialize: ->
    @url = @$container.attr('href')
    @data = @$container.data()
    @$target = maven.get(@$container.data('target')) || @$container
    @$container.click @link_clicked

  link_clicked: =>
    return false if @$container.hasClass('pending')

    @data['jsWidget'] = undefined
    @data['js-widget'] = undefined

    @$container.removeClass('active')
    @$container.addClass('pending')

    maven.Ajax.post(@url, @data, {success: @render_link, replace: @on_replace})
    return false

  render_link: (response) =>
    @$container.removeClass('pending')
    @$container.addClass('active')
    maven.replace_html(@$target, response['html'])

  on_replace: (response) =>
    @$container.removeClass('pending')
    @$container.addClass('active')
    maven.replace_container(@$target, response['html'])
