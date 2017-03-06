class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
      user = User.find_by username: params[:username]

      if user.banned
        redirect_to :back, notice: "Your account is frozen, please contact admin"
      elsif user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      elsif !user || !user.authenticate(params[:password])
        redirect_to :back, notice: "Username and/or password mismatch"      
      end
  end

  def create_oauth
    auth = request.env["omniauth.auth"]    
    user = User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end