class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]  
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    flash[:success] = "Welcome Drinkspottings!"
    redirect_to root_url
  end
  
  def new_user_app
    uid = params[:uid]
    user = "no"
    if User.find_by_uid(uid)
      user = "yes"
    end
    render :text => user
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
