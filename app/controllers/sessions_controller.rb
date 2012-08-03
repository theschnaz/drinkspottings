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
    
    unless User.find_by_uid(uid)
     user_data = FbGraph::User.fetch(uid)
     user = User.new
     user.name = user_data.name
     user.username = user_data.username
     user.email = user_data.email
     user.fb_pic_square = 'http://graph.facebook.com/' + user_data.id + '/picture?type=square'
     user.fb_pic_large = 'http://graph.facebook.com/' + user_data.id + '/picture?type=large'
     user.provider = 'facebook'
     user.uid = user_data.id
     user.save
     
    end
    render :text => user.name
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
