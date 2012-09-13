class IphonesController < ApplicationController

  def all

    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name, "tags".name as tagname FROM "posts", "users", "venues", "tags" WHERE "posts".venue_id = "venues".id AND "posts".posted_by = "users".id and "tags".drink_id = "posts".id ORDER BY posts.created_at DESC']
    
    render :json => @drinks.to_json(:methods => [:post_url])

  end


end
