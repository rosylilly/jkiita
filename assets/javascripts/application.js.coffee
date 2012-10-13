#= require jquery-1.8.2.min
#= require shortcut
#= require qiita/client

$ ()->
  scrolling = $(window).height() / 2
  $.client = new Qiita.Client()

  $.client.timeline()

  shortcut.add 'j', ()->
    uuid = $('li.active').next().attr('data-uuid')
    $.client.select(uuid)

  shortcut.add 'k', ()->
    uuid = $('li.active').prev().attr('data-uuid')
    $.client.select(uuid)

  shortcut.add 'Space', ()->
    view = $('#view').get(0)
    view =
      height: view.scrollHeight
      offset: view.offsetHeight

    if $('#view').scrollTop() + view.offset < view.height
      $('#view').stop(1).animate({scrollTop: ($('#view').scrollTop() + scrolling) + 'px'}, 100)
    else
      uuid = $('li.active').next().attr('data-uuid')
      $.client.select(uuid)

  shortcut.add 'Shift+Space', ()->
    view = $('#view').get(0)
    view =
      height: view.scrollHeight
      offset: view.offsetHeight

    if $('#view').scrollTop() > 0
      $('#view').stop(1).animate({scrollTop: ($('#view').scrollTop() - scrolling) + 'px'}, 100)
    else
      uuid = $('li.active').prev().attr('data-uuid')
      $.client.select(uuid)

  shortcut.commandMode = true
