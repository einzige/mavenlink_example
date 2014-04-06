# Global events
# See more: https://github.com/cowboy/jquery-tiny-pubsub
(->
  o = $(window.maven)

  window.maven.sub   = -> o.on.apply      o, arguments
  window.maven.unsub = -> o.off.apply     o, arguments
  window.maven.pub   = -> o.trigger.apply o, arguments
)()

# HTML helpers
window.maven.replace_container = (container, replacement) ->
  $container = $(container)
  maven.Widget.destroy($container)
  maven.Core.destroy_widgets($container)
  $parent = $container.parent()
  $container.replaceWith(replacement)
  maven.Core.init_widgets($parent)

window.maven.replace_html = (container, replacement) ->
  maven.Core.destroy_widgets($(container))
  $(container).html(replacement)
  maven.Core.init_widgets(container)

window.maven.append_html = (container, replacement) ->
  $(container).append(replacement)
  maven.Core.init_widgets(container)

window.maven.prepend_html = (container, replacement) ->
  $(container).prepend(replacement)
  maven.Core.init_widgets(container)

window.maven.clear_html = (container) ->
  maven.Core.destroy_widgets($(container))
  $(container).empty()

window.maven.get = (identifier) ->
  elem = $("[data-identifier=#{identifier}]")
  if elem.length > 0
    return elem
  else
    return null