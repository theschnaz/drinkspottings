class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    #@posted_and_liked_drinks = Post.find_by_sql ['SELECT "posts".* FROM "posts" WHERE ("posts".posted_by = ? ) ORDER BY posts.created_at DESC', @user.id]
    @posted_and_liked_drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "tags".id as tagid, "tags".name as tagname FROM "posts", "users", "tags" WHERE ("posts".id = "tags".drink_id AND "posts".posted_by = ? AND "users".id = ? ) ORDER BY posts.created_at DESC', @user.id, @user.id]
  end


end
