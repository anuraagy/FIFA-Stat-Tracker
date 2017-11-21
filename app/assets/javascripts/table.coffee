class Table
  constructor: (@element) ->
    @table  = @element.find("table")
    @search = @element.find("#search")
    @rows   = @element.find("table tr")

    @rows   = @rows.slice(1)
    @search.on "keyup", @filter

  filter: =>
    val = '^(?=.*\\b' + $.trim(@search.val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$'
    reg = RegExp(val, 'i')
    text = undefined
    
    @rows.show().filter(->
      text = $(this).text().replace(/\s+/g, ' ')
      !reg.test(text)
    ).hide()

$ ->
  new Table($("body"))
