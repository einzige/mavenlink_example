# All requests go through maven.Ajax
class maven.Ajax
  @get:  (path, params, callbacks = {}) -> (new maven.Ajax(path, params, callbacks)).get()
  @post: (path, params, callbacks = {}) -> (new maven.Ajax(path, params, callbacks)).post()

  # Usage: maven.Ajax.getScript('//code.com/script.js').done(callback)
  @getScript: (url) ->
    options = {
      url: url
      dataType: 'script'
      cache: true
    }
    jQuery.ajax(options)

  constructor: (path, params = {}, callbacks = {}) ->
    @path      = path
    @params    = params
    @callbacks = callbacks
    @before    = callbacks['before'] || ->
    @after     = callbacks['after'] || ->

  get:  -> @perform_request('GET')
  post: -> @perform_request('POST')

  perform_request: (type) ->
    @options = {}
    @options['beforeSend'] = @before
    @options['type']       = type
    @options['data']       = @params

    token = $('meta[name="csrf-token"]').attr('content')

    if (token)
      csrf_param = $('meta[name=csrf-param]').attr('content');
      @options['data'][csrf_param] = token

    $.ajax(@path, @options).done(@on_response_received).fail(@on_bad_response_received).always(@after)

  on_bad_response_received: =>
    maven.Logger.error("Invalid request on #{@path}")

  on_response_received: (response) =>
    if callback = @callbacks[response['status']]
      callback(response)
    else
      switch response['status']
        when 'redirect'
          window.location.hash = response['url'] || window.location
        when 'failed'
          alert(response['message'] || "Invalid request on #{@path}")
        when 'reload'
          window.location.reload()
