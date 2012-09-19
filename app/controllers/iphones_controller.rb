class IphonesController < ApplicationController

  def all

    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "venues" WHERE "posts".venue_id = "venues".id AND "posts".posted_by = "users".id ORDER BY posts.created_at DESC']
    
    #render :json => @drinks.to_json(:methods => [:post_url, :tags])
	render :json => @drinks.to_json(:methods => [:post_url])

  end
  
  def local
    lat = params[:lat].to_f
    long = params[:long].to_f
    
    type = params[:type]

    distance = 0.0036
  
    west = long - distance
    east = long + distance
    north = lat + distance
    south = lat - distance
    
    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "venues" WHERE "posts".venue_id = "venues".id AND "posts".posted_by = "users".id AND "venues".lat > \'' + south + '\' AND "venues".lat < \'' + north + '\' AND "venues".lng > \'' + west + '\' AND "venues".lng < \'' + east + '\' ORDER BY posts.created_at DESC']
    
    render :json => @drinks.to_json(:methods => [:post_url])
  
  end


end
