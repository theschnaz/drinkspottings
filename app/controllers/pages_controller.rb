class PagesController < ApplicationController
  def home
    @title = "Home"
    @posted_and_liked_drinks = Post.find_by_sql ['SELECT "posts".* FROM "posts" WHERE ("posts".posted_by = ?) ORDER BY posts.created_at DESC', current_user.id]

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
