class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    #@posted_and_liked_drinks = Post.find_by_sql ['SELECT "posts".* FROM "posts" WHERE ("posts".posted_by = ? ) ORDER BY posts.created_at DESC', @user.id]
    #posted and liked drinks
    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id FROM "posts", "users", "venues" WHERE ("posts".posted_by = "users".id AND "posts".venue_id = "venues".id AND "users".id = ? ) ORDER BY posts.created_at DESC', @user.id]
  end


end
