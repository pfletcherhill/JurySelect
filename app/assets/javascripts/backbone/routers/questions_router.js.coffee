class JurySelection.Router extends Backbone.Router
  
  initialize: (options) ->
    @questions = new JurySelection.Collections.Questions(options.questions)
    @currentUser = new JurySelection.Models.User(options.currentUser)

  routes:
    "questions"                 : "questions"
    "trials"                    : "trials"
    "trials/:id/setup"          : "trialSetup"
    "trials/:id/questions/:qid" : "trialQuestion"
    "trials/:id/review"         : "trialReview"
    ".*"                        : "questions"

  questions: ->
    @indexView = new JurySelection.Views.Index() unless @indexView
    @indexView.render(@questions, @currentUser)

  trials: ->
    @trials = new JurySelection.Collections.Trials
    @trials.url = "/users/" + @currentUser.id + "/trials"
    @trials.fetch( success: (trials) =>
      @view = new JurySelection.Views.Trials(questions: @questions, currentUser: @currentUser, trials: trials)
    )
  
  trialSetup: (id) ->
    @trial = new JurySelection.Models.Trial
    @trial.url = "/trials/" + id
    @trial.fetch( success: (trial) =>
      @trialView = new JurySelection.Views.Trial(currentUser: @currentUser, questions: @questions) unless @trialView
      @trialView.renderSetup(trial)
    )
  
  trialQuestion: (id, qid) ->
    @trial = new JurySelection.Models.Trial
    @trial.url = "/trials/" + id
    @trial.fetch( success: (trial) =>
      @trialView = new JurySelection.Views.Trial(currentUser: @currentUser, questions: @questions) unless @trialView
      @trialView.renderQuestion(trial, qid)
    )
    
  trialReview: (id) ->
    @trial = new JurySelection.Models.Trial
    @trial.url = "/trials/" + id + "/review"
    @trial.fetch( success: (data) =>
      @view = new JurySelection.Views.Review(trial: data)
    )