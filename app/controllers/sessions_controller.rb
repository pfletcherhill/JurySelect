class SessionsController < ApplicationController
  
  def new
  end
  
  def create  
    user = User.authenticate(params[:email], params[:password])
    if user  
      session[:user_id] = user.id
      redirect_to "/", :notice => "Welcome back #{user.name}"  
    else
      redirect_to "/login", :notice => "Invalid Email or Password!"
    end  
  end
  
  def destroy  
    session[:user_id] = nil  
    redirect_to "/", :notice => "Logged Out"  
  end
  
end
