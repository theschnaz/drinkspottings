class TagsController < ApplicationController


  def show
    @tag = Tag.find(:first, :conditions => ["name = ?", params[:id]])
    #@drinks = Tag.find(:all, :conditions => ["name = ?", params[:id]])
    
    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid FROM "posts", "users", "tags" WHERE ("tags".drink_id = "posts".id  AND "tags".user_id = "users".id AND "tags".name = ? ) ORDER BY posts.created_at DESC', params[:id]]
    
    #render :json => @drink_ids
    
  end


end