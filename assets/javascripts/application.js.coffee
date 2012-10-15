#= require jquery-1.8.2.min
#= require shortcut
#= require qiita/client

$ ()->
  scrolling = ->
    $(window).height() / 2
  client = new Qiita.Client()

  get = (callback)->
    return if client.loading
    client.timeline(callback)

  get ()->
      client.select($('#items li:first-child').attr('data-uuid'))

  next = ->
    uuid = $('li.active').next().attr('data-uuid')
    unless client.select(uuid)
      get()

  prev = ->
    uuid = $('li.active').prev().attr('data-uuid')
    client.select(uuid)

  $('#items li').live('click', () ->
      client.select $(@).attr('data-uuid')
      )

  shortcut.add 'j', ()->
    next()

  shortcut.add 'k', ()->
    prev()

  shortcut.add 'Space', ()->
    view = $('#view').get(0)
    view =
      height: view.scrollHeight
      offset: view.offsetHeight

    if $('#view').scrollTop() + view.offset < view.height
      $('#view').stop(1).animate({scrollTop: ($('#view').scrollTop() + scrolling()) + 'px'}, 100)
    else
      next()

  shortcut.add 'Shift+Space', ()->
    view = $('#view').get(0)
    view =
      height: view.scrollHeight
      offset: view.offsetHeight

    if $('#view').scrollTop() > 0
      $('#view').stop(1).animate({scrollTop: ($('#view').scrollTop() - scrolling()) + 'px'}, 100)
    else
      prev()

  shortcut.commandMode = true
