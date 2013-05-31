class JurySelection.Models.User extends Backbone.Model
  
  paramRoot: 'user'

  defaults:
    "name" : null
    "email" : null

class JurySelection.Collections.Users extends Backbone.Collection
  
  model: JurySelection.Models.User
  url: '/users'
