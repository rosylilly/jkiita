class Item
  constructor: (data)->
    for key, value of data
      @[key] = value
