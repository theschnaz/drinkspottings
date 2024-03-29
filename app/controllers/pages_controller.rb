class PagesController < ApplicationController
  def home
  	@mode = params[:mode]
  
    @title = "Home"
    
    if current_user
      #@user = current_user
      #this will display all drinks from all users
      @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "venues" WHERE "posts".venue_id = "venues".id AND "posts".posted_by = "users".id ORDER BY posts.created_at DESC']
    else
      @home_no_current_user = true
    end
    
    if current_user
      @saved_drinks = Save.find_by_sql ['SELECT "saves".drink_id as ID FROM "saves" WHERE "saves".user_id = \'' + current_user.id.to_s + '\'']
    end
        
    #if @mode == 'app'
    #  render "home_app"
    #end

  end
  
  def saved_drinks
  	#@mode = params[:mode]
  
    @title = "Your Saved Drinks"
    
    if current_user
      #@user = current_user
      #this will display all drinks from all users
      @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "venues", "saves" WHERE "posts".venue_id = "venues".id AND "posts".posted_by = "users".id AND "posts".id = "saves".drink_id AND "saves".user_id = 														\'' + current_user.id.to_s + '\' ORDER BY saves.id DESC']
    end
    
    if current_user
      @saved_drinks = Save.find_by_sql ['SELECT "saves".drink_id as ID FROM "saves" WHERE "saves".user_id = \'' + current_user.id.to_s + '\'']
    end
        
    #if @mode == 'app'
    #  render "home_app"
    #end

  end
  
  def all
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end
