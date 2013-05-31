JurySelection::Application.routes.draw do
  
  root :to => "users#questions"
  
  # Authentication
  match "/login" => "sessions#new"
  match "/logout" => "sessions#destroy"
  match "/register" => "users#new"
  
  # Resources
  resources :users, :questions, :jurors, :trials, :sessions
  
  # User-specific collections
  match "/users/:id/trials" => "users#trials"
  
  # Trials
  match "/trials/:id/questions" => "trials#questions"
  match "/trials/:id/add_question/:question_id" => "trials#add_question"
  match "/trials/:id/validate/:question_id" => "trials#validate_question"
  match "/trials/:id/review" => "trials#review"
  
  # Jurors
  match "/questions/:id/jurors" => "questions#jurors"
  
end
