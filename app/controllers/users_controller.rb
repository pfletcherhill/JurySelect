class UsersController < ApplicationController
  
  before_filter :require_login, :only => ["questions"]

  def require_login
    unless logged_in?
      redirect_to '/login' # halts request cycle
    end
  end
 
  def logged_in?
    !!current_user
  end
  
  def index
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])  
    if @user.save  
      session[:user_id] = @user.id   
      redirect_to root_url, :notice => "Welcome!"
    else  
      redirect_to "/register"  
    end
  end
  
  def trials
    @trials = current_user.trials if current_user
    render :json => @trials.as_json(:methods => [:questions_count, :jurors_count])
  end
  
  def questions
    @questions = current_user.questions if current_user
  end
    
end
