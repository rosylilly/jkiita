#= require qiita/auth

class @Qiita
class Qiita.Client
  _end_point = 'https://qiita.com/api/v1/'
  constructor: (username, password)->
    auth_url = _end_point + "auth"
    opts =
      url: auth_url
      type: 'POST'
      data:
        url_name :username
        password :password
      dataType:'json'
    $.ajax(opts).done (result)=>
      @token = result.token
      @username = result.url_name
      console.log @

  get = (params) ->
    # branch if _token

  post = (params) ->
    # branch if _token

  stock: (uuid) ->
    # use self#post

  timeline:->
    # use self#post
    add_item = (item,i)->
      img = $('img').attr('src',item.user.profile_image_url)
      li = $('li').attr('id','item'+i).addClass('item').append(img).append(item.title)
      $('ul').append(li)
    $.ajax({url:_end_point + 'items'})
      .done((d)->
        @timeline = d 
        add_item(item,i)  for item,i in d
      )
