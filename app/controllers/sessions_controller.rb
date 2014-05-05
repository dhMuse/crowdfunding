class SessionsController < ApplicationController
  
  def new
  end
  
  def create
  	user = User.find_by_email(params[:email])
    respond_to do |format|
    	if user && user.authenticate(params[:password])
    		session[:user_id] = user.id
    		format.html { redirect_to root_path, notice: "You're logged in!" }
        format.js do
          flash.now.notice = "You're signed in!"
          render
        end
    	else
    		flash.now.alert = "Email or password is invalid"
        format.html { render :new }
    		format.js { render :new }
    	end
    end
  end

  def destroy
  	respond_to do |format|
      session[:user_id] = nil
      format.html { redirect_to root_path, notice: "You're logged out!" }
      format.js do
        flash.now.notice = "You're signed out!"
        render
      end
    end
  end

end
