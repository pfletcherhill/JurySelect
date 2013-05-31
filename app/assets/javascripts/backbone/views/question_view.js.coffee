JurySelection.Views ||= {}

class JurySelection.Views.Question extends Backbone.View
  
  template: JST["backbone/templates/question"]
  
  initialize: (options) ->
    @model = options.question
    @questions = options.questions
    @jurors = options.jurors
  
  addOne: (juror) ->
    html = "<div class='juror'>" + juror.get("number") + "</div>"
    $(".jurors").append html
  
  reset: =>
    $("input[type='text']").val("")
    $("input#number").focus()
     
  render: =>
    $(@el).html(@template(@model.toJSON()))
    return this
  
  events: 
    "submit form#new-juror" : "submit"
    "click #next" : "next"
  
  submit: (event) =>
    event.preventDefault()
    n = $("input[name='number']").val()
    juror = @jurors.where({ number : n })[0]
    unless juror
      juror = new JurySelection.Models.Juror({ number: n })
      @jurors.add juror
    juror.addQuestion(@model)
    @addOne(juror)
    @reset()
  
  next: =>
    i = @questions.indexOf @model
    if @questions.length > i + 1
      id = @questions.models[1].get("abbreviation")
      window.location = "#question/" + id
    else
      window.location = "#review"