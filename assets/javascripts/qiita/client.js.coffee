#= require qiita/auth

class @Qiita
class Qiita.Client
  _end_point = 'https://qiita.com/api/v1/'
  constructor: ()->
    @items = {}

  get: (url, params, callback) ->
    @request(url, params, callback, 'GET')

  post: (url, params, callback) ->
    @request(url, params, callback, 'POST')

  put: (url, params, callback) ->
    @request(url, params, callback, 'PUT')

  request: (url, params, callback, type = 'GET') ->
    params.token = @token if @token?
    $.ajax
      url: _end_point + url
      data: params
      dataType: 'json'
      type: type
      success: callback

  stock: (uuid) ->
    @put "items/#{uuid}/stock", {}, (data) ->
      # do nothing

  add: (item, i) ->
    @items[item.uuid] = item
    img = $('<img />').attr('src', item.user.profile_image_url)
    li = $('<li />').attr('id','item'+i).addClass('item').append(img).append(item.title)
    li.attr('data-uuid', item.uuid);
    $('ul').append(li);

  select: (uuid) ->
    rerturn unless uuid?
    $('li.active').removeClass('active')
    item = @items[uuid]
    $('header > h1').text(item.title);
    $('#body').html(item.body);
    $("li[data-uuid=#{uuid}]").addClass('active')

  timeline:->
    # use self#post
    $.ajax({url:_end_point + 'items'})
      .done((d)=>
        @timeline = d
        @add(item,i)  for item,i in d
        @select(d[0].uuid) if d[0]?
      )
