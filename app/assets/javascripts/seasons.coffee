class Seasons
  constructor: (@element) ->
    @start = @element.find("#season_start")
    @end   = @element.find("#season_end")

    $("#standings").tablesorter({
      sortList: [[1,1]],
      sortDirection: 0
    });
    
$ ->
  new Seasons($("body"))
