JurySelection.Views ||= {}

class JurySelection.Views.Index extends Backbone.View
  
  template: JST["backbone/templates/index"]
  questionTemplate: JST["backbone/templates/question_row"]

  el: "#container"
  
  initialize: (options) ->

  addOne: (question) =>
    $(".questions").append @questionTemplate(question.toJSON())
  
  reset: =>
    @newQuestion = new JurySelection.Models.Question({user_id: @currentUser.get("id")})
    $("form#new-question").backboneLink(@newQuestion)
    $("input[type='text']").val("")
    $("textarea").val("")
    $("input#abbrev").focus()
     
  render: (questions, currentUser) =>
    @questions = questions
    @currentUser = currentUser
    $(@el).html(@template())
    @reset()
    for q in @questions.models
      @addOne(q)
    return this

  events:
    "submit form#new-question" : "save"
    "click #next" : "next"
    "click #delete-question" : "delete"
    "click #close-popover" : "close"
    "click #open-popover" : "open"
  
  save: (event) =>
    event.preventDefault()
    @newQuestion.set
      text: $("textarea").val()
      abbreviation: $("input#abbrev").val()
    if @newQuestion.isValid()
      @newQuestion.url = "/questions"
      @newQuestion.save(@newQuestion, 
        success: (question) =>
          $(".cover").removeClass "open"
          @questions.add question
          @addOne question
          @reset()
        error: (data) ->
          alert "Unable to save question"
          $("input#abbrev").focus()
      )
    else
      alert "Question must be filled out"
  
  delete: (event) ->
    if confirm "Are you sure?"
      id = $(event.target).data("id")
      question = @questions.get(id)
      question.url = "/questions/" + id
      question.destroy( success: (question) =>
        @questions.remove(question)
        $(".questions tr[data-id='" + question.id + "']").remove()
      )
  
  next: (event) =>
    if @questions.length > 0
      id = @questions.models[0].get("abbreviation")
      window.location = "#question/" + id
    else
      alert "No Questions Entered"
  
  open: (event) ->
    $(".cover").addClass "open"
    $("input#abbrev").focus()
    
  close: (event) ->
    $(".cover").removeClass "open"