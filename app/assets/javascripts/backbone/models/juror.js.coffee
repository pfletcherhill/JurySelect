class JurySelection.Models.Juror extends Backbone.Model
  paramRoot: 'juror'

  defaults:
    number: null
    trial_id: null
    notes: null
  
  addQuestion: (question) ->
    if @get("questions")
      questions = @get("questions")
    else
      questions = new JurySelection.Collections.Questions
      @set "questions", questions
    questions.add question
  
  validate: (attrs, options) ->
    if attrs.number == null
      return "Must have number"

class JurySelection.Collections.Jurors extends Backbone.Collection
  model: JurySelection.Models.Juror
  url: '/jurors'
