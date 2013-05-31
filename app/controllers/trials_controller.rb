class TrialsController < ApplicationController
  
  before_filter :require_login

  def require_login
    unless logged_in?
      redirect_to '/login' # halts request cycle
    end
  end
 
  def logged_in?
    !!current_user
  end
  
  def index
    @trials = Trial.all
    render json: @trials
  end
  
  def create
    @trial = Trial.new(params[:trial])
    if @trial.save
      render json: @trial
    else
      render json: @trial.errors
    end
  end
  
  def show
    @trial = Trial.find(params[:id])
    render json: @trial
  end
  
  def destroy
    @trial = Trial.find(params[:id])
    @trial.destroy
    render json: @trial
  end
  
  #Questions
  
  def questions
    @questions = Trial.find(params[:id]).questions
    render json: @questions
  end
  
  def add_question
    @trial = Trial.find(params[:id])
    @question = Question.find(params[:question_id])
    @trial.questions << @question
    render json: @question
  end
  
  def validate_question
    @question_trial = QuestionTrial.where(:question_id => params[:question_id], :trial_id => params[:id]).first
    if @question_trial
      @question_trial.complete = true
      @question_trial.save
      render json: @question_trial
    end
  end
  
  #Review
  
  def review
    @trial = Trial.find(params[:id])
    render json: @trial.to_json(:include => {:jurors => {:include => [:questions]}})
  end
  
end
