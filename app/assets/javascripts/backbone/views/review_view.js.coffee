JurySelection.Views ||= {}

class JurySelection.Views.Review extends Backbone.View
  
  template: JST["backbone/templates/review"]
  
  el: "#container"
  
  initialize: (options) ->
    @trial = options.trial
    @render()
  
  render: ->
    $(@el).html(@template(jurors: @trial.get("jurors")))
    return this
  
  events: 
    "change .juror-notes textarea" : "note"
  
  note: (event) ->
    id = $(event.target).data('id')
    jurors = new JurySelection.Collections.Jurors(@trial.get("jurors"))
    juror = jurors.get(id)
    juror.url = "/jurors/" + juror.id
    juror.unset("questions")
    juror.save({notes: $(event.target).val()}, 
      success: (data) ->
        $("textarea[data-id='" + id + "']").addClass("highlighted").delay(500).queue( ->
          $("textarea[data-id='" + id + "']").removeClass("highlighted")
        )
    )
    