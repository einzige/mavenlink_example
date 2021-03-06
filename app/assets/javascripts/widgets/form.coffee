# @data target [String, null]
class maven.widgets.Form extends maven.Widget
  @SELECTOR = '.Form'

  initialize: ->
    @$container.submit @on_submit
    @$error = @$container.find('.Error')
    if @$container.data('target')
      @$target = maven.get(@$container.data('target'))
    else
      @$target = @$container

  on_submit: =>
    path = @$container.attr('action')
    params = @params()
    callbacks = {
      success: @on_success,
      replace: @on_replace,
      before:  @on_before,
      after:   @on_after,
      failed:  @on_fail
    }
    method = @$container.attr('method')

    request = new maven.Ajax(path, params, callbacks)
    request.perform_request(method)

    return false

  on_success: =>
    _.each @$container.find('input[data-target]'), (field) ->
      $field = $(field)
      $target = maven.get($field.data('target'))
      maven.replace_html($target, $field.val())

  on_replace: (response) =>
    if @$target == @$container
      maven.replace_container(@$target, response['html'])
    else
      maven.replace_html(@$target, response['html'])

  on_before: =>
    _.each @params(), (value, field) =>
      @$container.find("[data-field]").html('').hide()
    @$container.addClass('pending')

  on_after: =>
    @$container.removeClass('pending')

  on_fail: (response) =>
    if message = response['message']
      if @$error.length > 0 then @$error.html(message)
      else alert(message)

    if errors = response['errors']
      _.each errors, (message, field) =>
        @$container.find("[data-field=#{field}]").html(message).show()

  # Override this method for custom forms
  params: ->
    result = {}
    _.each @$container.find('input, select, textarea'), (input) ->
      $input = $(input)
      result[$input.attr('name')] = $input.val()

    result
