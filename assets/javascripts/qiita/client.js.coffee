#= require qiita/auth

class @Qiita
class Qiita.Client
  _end_point = 'https://qiita.com/api/v1/'
  constructor: ()->
    @items = {}
    @loading = false

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
    return if @items[item.uuid]
    @items[item.uuid] = item
    img = $('<img />').attr('src', item.user.profile_image_url)
    li = $('<li />').attr('id','item'+i).addClass('item').append(img).append(item.title)
    li.attr('data-uuid', item.uuid);
    $('ul').append(li);

  select: (uuid) ->
    return false unless uuid?
    $('li.active').removeClass('active')
    item = @items[uuid]
    $('header > h1').text(item.title)
    $('#body').html(item.body)
    ofs = $("li[data-uuid=#{uuid}]").addClass('active').offset().top;
    $('#items').stop(1).animate({scrollTop: ($('#items').scrollTop() + ofs) + 'px'}, 100)
    $('#view').scrollTop(0)
    true

  timeline: (callback)->
    # use self#post
    @loading = true
    $.ajax({url:_end_point + "items?per_page=100"})
      .done((d, type, xhr)=>
          @add(item,i)  for item,i in d.reverse()
          @loading = false
          callback?()
          )
