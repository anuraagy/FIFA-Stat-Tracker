class Seasons
  constructor: (@element) ->
    @start = @element.find("#season_start")
    @end   = @element.find("#season_end")






$ ->
  new Seasons($("body"))
