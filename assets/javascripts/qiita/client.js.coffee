#= require qiita/auth

class @Qiita
class Qiita.Client
  _end_point = 'https://qiita.com/api/v1/'
  _token = ''
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

  get: (params) ->
    # branch if _token

  post: (params, callback) ->
    # branch if _token
    params.token = @token if @token?
    $.getJSON(_end_point, params).done(callback)

  stock: (uuid) ->
    # use self#post

  timeline: () ->
    # use self#post







