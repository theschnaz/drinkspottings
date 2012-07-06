class PagesController < ApplicationController
  def home
    @title = "Home"
    
    if current_user
      @user = current_user
      @posted_and_liked_drinks = Post.find_by_sql ['SELECT "posts".* FROM "posts" WHERE ("posts".posted_by = ?) ORDER BY posts.created_at DESC', @user.id]
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
