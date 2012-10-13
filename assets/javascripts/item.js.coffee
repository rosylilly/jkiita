class Item
  constructor: (data)->
    for key, value of data
      @[key] = value

  stock: ()->
    return unless @client?
    @client.stock(@uuid)
