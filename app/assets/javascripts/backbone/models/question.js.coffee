class JurySelection.Models.Question extends Backbone.Model
  
  paramRoot: 'question'
  #url: '/questions'
  
  defaults:
    text: null
    abbreviation: null
    user_id: null
  
  validate: (attrs, options) ->
    if attrs.text == null || attrs.abbreviation == null || attrs.user_id == null
      return "Text and abbreviation must be entered"

class JurySelection.Collections.Questions extends Backbone.Collection
  
  model: JurySelection.Models.Question
  url: '/questions'
