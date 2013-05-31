JurySelection.Views ||= {}

class JurySelection.Views.Trials extends Backbone.View
  
  template: JST["backbone/templates/trials"]
  trialTemplate: JST["backbone/templates/trial_row"]
  questionTemplate: JST["backbone/templates/trial_question_row"]

  el: "#container"
  
  initialize: (options) ->
    @questions = options.questions
    @currentUser = options.currentUser
    @trials = options.trials
    @render()
  
  renderTrials: ->
    for trial in @trials.models
      $("table.trials").append(@trialTemplate(trial.toJSON()))
    
  renderQuestions: ->
    for q in @questions.models
      $(".trial-questions").append(@questionTemplate(q.toJSON()))
    
  render: ->
    $(@el).html(@template(trials: @trials))
    @renderTrials()
    #@renderQuestions()
    return this
    
  events: 
    "click #start-trial" : "newTrial"
    "click #delete-trial" : "delete"
  
  newTrial: (event) ->
    @newTrial = new JurySelection.Models.Trial
    @newTrial.url = "/trials"
    @newTrial.save({user_id: @currentUser.id}, success: (trial) =>
      id = trial.get("id")
      window.location.hash = "#trials/" + id + "/setup"
    )
  
  delete: (event) ->
    if confirm "Are you sure?"
      id = $(event.target).data("id")
      trial = @trials.get(id)
      trial.url = "/trials/" + id
      trial.destroy( success: (data) =>
        @trials.remove(data)
        $(".trials tr[data-id='" + data.id + "']").remove()
      )