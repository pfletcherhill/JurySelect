class QuestionsController < ApplicationController
  
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
    @questions = Question.all
    render json: @questions
  end
  
  def create
    @question = Question.new(params[:question])
    if @question.save
      render json: @question
    else
      render json: @question, :status => 420
    end
  end
  
  def show
    @question = Question.find(params[:id])
    render json: @question
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    render json: @question
  end
  
  def jurors
    @question = Question.find(params[:id])
    @jurors = @question.trial_jurors(params[:trial_id])
    render json: @jurors
  end
  
end
