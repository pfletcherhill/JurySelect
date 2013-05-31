class JurorsController < ApplicationController
  
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
    @jurors = Juror.all
    render json: @jurors
  end
  
  def create
    # Finds or creates juror by number
    @juror = Juror.where(:number => params[:juror][:number], :trial_id => params[:juror][:trial_id]).first
    unless @juror
      @juror = Juror.create(params[:juror])
    end
    # Gets question
    @question = Question.where(:id => params[:question_id]).first
    if @question
      if @juror.questions.exists? (params[:question_id])
        render :json => @juror, :status => 422
      else
        if @juror.questions << @question
          render json: @juror
        else
          render json: [:message => "Unable to add question to juror"], :status => 500
        end
      end
    else
      render json: [:message => "Question does not exist"], :status => 400
    end
  end
  
  def update
    @juror = Juror.find(params[:id])
    if @juror.update_attributes(params[:juror])
      render json: @juror
    else
      render json: @juror, :status => 420
    end
  end
  
end
