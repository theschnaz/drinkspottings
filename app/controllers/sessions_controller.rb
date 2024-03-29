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
    
    user = User.find_by_uid(uid)
    
    unless User.find_by_uid(uid)
     user_data = FbGraph::User.fetch(uid)
     user = User.new
     user.name = user_data.name
     user.facebook_key = params[:key]
     user.newsletter = params[:newsletter]
     user.username = user_data.username
     user.email = user_data.email
     user.fb_pic_square = 'http://graph.facebook.com/' + user_data.identifier + '/picture?type=square'
     user.fb_pic_large = 'http://graph.facebook.com/' + user_data.identifier + '/picture?type=large'
     user.provider = 'facebook'
     user.uid = user_data.identifier
     user.save
    end
    
    #if the user already exits, they are sent here becuase of a FB token issue, update token here
    if User.find_by_uid(uid)
      user.facebook_key = params[:key]
      user.save
    end
    
    render :text => user.name
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
