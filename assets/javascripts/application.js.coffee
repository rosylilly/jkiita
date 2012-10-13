#= require jquery-1.8.2.min
#= require shortcut
#= require qiita/client

$ ()->
  $.client = new Qiita.Client()

  $.client.timeline()

  shortcut.add 'j', ()->
    uuid = $('li.active').next().attr('data-uuid')
    $.client.select(uuid)

  shortcut.add 'k', ()->
    uuid = $('li.active').prev().attr('data-uuid')
    $.client.select(uuid)

  shortcut.commandMode = true
