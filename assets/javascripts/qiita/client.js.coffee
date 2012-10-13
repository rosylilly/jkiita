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

  timeline: () ->
    # use self#post







