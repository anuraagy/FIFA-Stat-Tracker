class Games
  constructor: (@element) ->
    @winner_select    = @element.find("#game_winner")
    @home_select      = @element.find("#game_home_user")
    @away_select      = @element.find("#game_away_user")
    @home_score       = @element.find("#game_home_score")
    @away_score       = @element.find("#game_away_score")
    @h_penalty_score  = @element.find("#game_home_penalty_score")
    @a_penalty_score  = @element.find("#game_away_penalty_score")


    @home_select.on  "change", @populateWinner
    @away_select.on  "change", @populateWinner

  populateWinner: =>
    if @home_select.val() != "" && @away_select.val() != ""
      @winner_select.empty()
      @winner_select.append("<option value>Select player</option>")
      @winner_select.append("<option value = '" + @home_select.val() + "'>" + @home_select.val() + "</option>")
      @winner_select.append("<option value = '" + @away_select.val() + "'>" + @away_select.val() + "</option>")

$ ->
  new Games($("body"))
