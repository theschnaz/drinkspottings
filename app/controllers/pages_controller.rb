class PagesController < ApplicationController
  def home
    @title = "Home"
    
    if current_user
      #@user = current_user
      #this will display all drinks from all users
      @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid FROM "posts", "users" WHERE "posts".posted_by = "users".id ORDER BY posts.created_at DESC']
    end

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
