class JurySelection.Models.Trial extends Backbone.Model
  paramRoot: 'trial'

  defaults:
    "user_id" : null
  
  addQuestion: (id, callback) ->
    $.ajax
      type: 'POST'
      dataType: 'json'
      url: "/trials/" + @id + "/add_question/" + id
      success: (data) ->
        question = new JurySelection.Models.Question(data)
        callback(question)
        
  validateQuestion: (id) ->
    # $.ajax
    #       type: 'POST'
    #       dataType: 'json'
    #       url: "/trials/" + @id + "/validate/" + id
    #       success: (data) =>
    window.location.hash = "#trials/" + @id + "/setup"

class JurySelection.Collections.Trials extends Backbone.Collection
  
  model: JurySelection.Models.Trial
  url: '/trials'
