class TagsController < ApplicationController


  def show
    @tag = Tag.find(:first, :conditions => ["name = ?", params[:id]])
    #@drinks = Tag.find(:all, :conditions => ["name = ?", params[:id]])
    
    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "tags", "venues" WHERE ("posts".venue_id = "venues".id AND "tags".drink_id = "posts".id  AND "tags".user_id = "users".id AND "tags".name = ? ) ORDER BY posts.created_at DESC', params[:id]]
    
    @saved_drinks = Save.find_by_sql ['SELECT "saves".drink_id as ID FROM "saves" WHERE "saves".user_id = \'' + current_user.id.to_s + '\'']
    
    ##render :json => @drink_ids
    
  end


end
