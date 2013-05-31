JurySelection.Views ||= {}

class JurySelection.Views.Trial extends Backbone.View
  
  template: JST["backbone/templates/trial"]
  setupTemplate: JST["backbone/templates/setup"]
  questionRowTemplate: JST["backbone/templates/trial_question_row"]
  questionTemplate: JST["backbone/templates/question"]

  el: "#container"
  
  initialize: (options) ->
    @currentUser = options.currentUser
    @questions = options.questions
    @model = options.trial
  
  reset: ->
    $("input[type='text']").val("")
    $("input#number").focus()
    
  renderSetup: (trial) ->
    @model = trial
    $(@el).html(@setupTemplate(questions: @questions, trial: @model))
    @trialQuestions = new JurySelection.Collections.Questions
    @trialQuestions.url = "/trials/" + @model.id + "/questions"
    @trialQuestions.fetch( success: (data) =>
      @renderQuestions(data)
    )
  
  addOne: (question) =>
    @trialQuestions.add question
    $("#questions").append(@questionRowTemplate(question: question.toJSON(), trial: @model))
  
  addJuror: (juror) ->
    $("#jurors").append("<div class='juror'>" + juror.get('number') + "</div>")
    @reset()
  
  renderQuestions: (questions) ->
    for question in questions.models
      @addOne question
  
  renderJurors: (jurors) ->
    for model in jurors.models
      @addJuror model
      
  renderQuestion: (trial, qId) ->
    @model = trial
    @question = new JurySelection.Models.Question
    @question.url = "/questions/" + qId
    @question.fetch( success: (question) =>
      $(@el).html(@questionTemplate(question: question.toJSON(), trial: @model))
      jurors = new JurySelection.Collections.Jurors
      jurors.url = "/questions/" + @question.id + "/jurors?trial_id=" + @model.id
      jurors.fetch success: (data) =>
        @renderJurors(data)
    )
  
  events: 
    "click #continue" : "firstQuestion"
    "change select" : "addQuestion"
    "submit #new-juror" : "newJuror"
    "click #done" : "done"
    "click #next-question" : "nextQuestion"
  
  firstQuestion: (event) =>
    id = @questions.at(0).id
    url = "#trials/" + @model.id + "/questions/" + id
    window.location.hash = url
  
  addQuestion: (event) ->
    id = $(event.target).val()
    @model.addQuestion(id, @addOne)
  
  newJuror: (event) ->
    event.preventDefault()
    num = $("#new-juror #number").val()
    @newJuror = new JurySelection.Models.Juror({ trial_id: @model.id, number: num })
    @newJuror.url = "/jurors?question_id=" + @question.id
    if @newJuror.isValid
      @newJuror.save(@newJuror,
        success: (data) =>
          @addJuror(data)
        error: (xhr) => 
          alert "Unable to add juror!"
          @reset()
      )
    else
      alert "You must enter a number!"
      @reset()
  
  done: (event) ->
    id = $(event.target).data("id")
    @model.validateQuestion(id)
  
  nextQuestion: (event) ->
    if @trialQuestions
      qId = $(event.target).data("id")
      question = @trialQuestions.get(qId)
      i = @trialQuestions.indexOf(question)
      if i == (@trialQuestions.length - 1)
        window.location.hash = "#trials/" + @model.id + "/setup"
      else
        id = @trialQuestions.at(i+1).get('id')
        window.location.hash = "#trials/" + @model.id + "/questions/" + id
    else
      @trialQuestions = new JurySelection.Collections.Questions
      @trialQuestions.url = "/trials/" + @model.id + "/questions"
      @trialQuestions.fetch success: (data) =>
        @nextQuestion(event)
    