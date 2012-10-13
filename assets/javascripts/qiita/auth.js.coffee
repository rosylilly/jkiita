class Auth
  _username = ''
  _pasword = ''
  _token = ''
  _end_point = 'https://qiita.com/api/v1/'
  constructor:(username,password)->
    auth_url = _end_point + "auth"
    $.ajax(
      url:auth_url
      type:'POST'
      data:
        url_name:username
        password:password
      dataType:'json'
    ).done((result)->
      _token = result
    )

