class Games
  constructor: (@element) ->
    @winner_select    = @element.find("#game_winner")
    @home_select      = @element.find("#game_home_user")
    @away_select      = @element.find("#game_away_user")
    @home_score       = @element.find("#game_home_score")
    @away_score       = @element.find("#game_away_score")
    @h_penalty_score  = @element.find("#game_home_penalty_score")
    @a_penalty_score  = @element.find("#game_away_penalty_score")
    @form             = @element.find("#new_game")

    @home_select.selectize({
        sortField: 'text'
    });
    @away_select.selectize({
        sortField: 'text'
    });

    @home_select.on      "change", @populateWinner
    @away_select.on      "change", @populateWinner
    @home_score.on       "change", @populateWinner
    @away_score.on       "change", @populateWinner
    @h_penalty_score.on  "change", @populateWinner
    @a_penalty_score.on  "change", @populateWinner

    @populateWinner()

    @form.submit ->
      @validateInput

  validateInput: =>
    if @home_select.val() == @away_select.val()
      e.preventDefault();
      alert("Please make sure that you choose two different players when submitting a game")

  populateWinner: =>
    if @home_score.val() == @away_score.val()
      @h_penalty_score.prop("disabled", false)
      @a_penalty_score.prop("disabled", false)
    else
      @h_penalty_score.val(0)
      @a_penalty_score.val(0)
      @h_penalty_score.prop("disabled", true)
      @a_penalty_score.prop("disabled", true)

    if parseInt(@home_score.val()) > parseInt(@away_score.val())
      @winner_select.empty()
      @winner_select.append("<option value='#{@home_select.val()}'>#{@home_select.val()}</option>")
    if parseInt(@home_score.val()) < parseInt(@away_score.val())
      @winner_select.empty()
      @winner_select.append("<option value='#{@away_select.val()}'>#{@away_select.val()}</option>")
    if parseInt(@h_penalty_score.val()) > parseInt(@a_penalty_score.val())
      @winner_select.empty()
      @winner_select.append("<option value='#{@home_select.val()}'>#{@home_select.val()}</option>")
      console.log(@h_penalty_score.val())
      console.log(@a_penalty_score.val())
    if parseInt(@h_penalty_score.val()) < parseInt(@a_penalty_score.val())
      @winner_select.empty()
      @winner_select.append("<option value='#{@away_select.val()}'>#{@away_select.val()}</option>")
    if @home_score.val() == @away_score.val() && @h_penalty_score.val() == @a_penalty_score.val()
      @winner_select.empty()
      @winner_select.append("<option value='Tie'>Tie</option>")


    # if @home_select.val() != "" && @away_select.val() != ""
    #   @winner_select.empty()
    #   @winner_select.append("<option value>Select player</option>")
    #   @winner_select.append("<option value = 'Tie'>Tie</option>")
    #   @winner_select.append("<option value = '" + @home_select.val() + "'>" + @home_select.val() + "</option>")
    #   @winner_select.append("<option value = '" + @away_select.val() + "'>" + @away_select.val() + "</option>")


$ ->
  new Games($("body"))
