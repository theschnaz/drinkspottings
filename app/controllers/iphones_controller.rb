class IphonesController < ApplicationController

  def all

    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "venues" WHERE "posts".venue_id = "venues".id AND "posts".posted_by = "users".id ORDER BY posts.created_at DESC']
    
    #render :json => @drinks.to_json(:methods => [:post_url, :tags])
	render :json => @drinks.to_json(:methods => [:post_url])

  end
  
  def local
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    #distance = 0.0036
  	distance = 0.006 
  
    west = lng - distance
    east = lng + distance
    north = lat + distance
    south = lat - distance
    
    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "venues" WHERE "posts".venue_id = "venues".id AND "posts".posted_by = "users".id AND "venues".lat >= \'' + south.to_s + '\' AND "venues".lat <= \'' + north.to_s + '\' AND "venues".lng >= \'' + east.to_s + '\' AND "venues".lng <= \'' + west.to_s + '\' ORDER BY posts.created_at DESC']
    
    render :json => @drinks.to_json(:methods => [:post_url])
  
  end


end
