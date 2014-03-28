class PostsController < ApplicationController

  def show
    @drink = Post.find(params[:id])
    
    @drink_page = true #this will include OG stuff in application.html.erb
    @drink_url = 'http://drinkspottings.com/posts/' + @drink.id.to_s
    
    @user = User.find(@drink.posted_by)
    #@posted_and_liked_drinks = Post.find_by_sql ['SELECT "posts".* FROM "posts" WHERE ("posts".posted_by = ? ) ORDER BY posts.created_at DESC', @user.id]
    #posted and liked drinks
    @drinks = Post.find_by_sql ['SELECT "posts".*, "users".name as personname, "users".fb_pic_square, "users".id as userid, "venues".id as venue_id, "venues".name as venue_name FROM "posts", "users", "venues" WHERE ("posts".posted_by = "users".id AND "posts".venue_id = "venues".id AND "users".id = ? AND "posts".id = ? ) ORDER BY posts.created_at DESC', @user.id, @drink.id]
    
    if current_user
      @saved_drinks = Save.find_by_sql ['SELECT "saves".drink_id as ID FROM "saves" WHERE "saves".user_id = \'' + current_user.id.to_s + '\'']
    elsif
      @login_promo == true
    end
  end

  #save the image from the app, then send the user to the next controller
  def post_photo_app
    @post = Post.new
    
    user = User.find_by_uid(params[:uid])
    @post.posted_by = user.id
     
    @post.photo = params[:photo]
    @post.save
    render :text => @post.id
  end
  
  def new_app
  	if request.referer
  	  @error = "Please name, rate, and post your drink at a venue."
  	end
  
  	@mobile = true
  	@post = Post.find_by_id(params[:drink_id])
  	
  	@drink_id = params[:drink_id]
    @lat = params[:lat]
    @long = params[:long]
    
    fourvenue = params[:lat] + "," + params[:long]
    
    #get nearby places from 4sq
    foursquare = Foursquare2::Client.new(:client_id => 'G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT', :client_secret => 'T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV', :api_version => '20120505')
    #@venues = foursquare.venues.search(:ll => fourvenue, :query => "walter food")
    @venues = foursquare.search_venues(:ll => fourvenue)
    
    #render :json => @venues
    
    @venues = @venues["venues"]
    #@venues = @venues["places"]
    #@venues =foursquare.venues.nearby(:ll => fourvenue)
    #render :text => @venues
    @venues = @venues[(0..9)]
  end
  
  def delete_app
    user = User.find_by_uid(params[:uid])
    
    if user
      drink = Post.find_by_id(params[:drink_id])
      drink.delete
    end
    
    render :text => "unposted"
  end
  
  def flag_app
    drink = Post.find_by_id(params[:drink_id])
    
    drink.flag = 1
    drink.save
    
    render :text => "flagged"
  end
  
  def new_app_venue
  	if request.referer
  	  @error = "Please name, rate, and post your drink at a venue."
  	end
  
  	@mobile = true
  	@post = Post.find_by_id(params[:drink_id])
  	
  	@drink_id = params[:drink_id]
    @lat = params[:lat]
    @long = params[:long]
  	@venue_name = params[:venue_name]
    
    fourvenue = params[:lat] + "," + params[:long]
    
    #get nearby places from 4sq
    foursquare = Foursquare::Base.new("G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT", "T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV")
    @venues = foursquare.venues.search(:ll => fourvenue, :query => @venue_name)
    @venues = @venues["places"]
    #@venues =foursquare.venues.nearby(:ll => fourvenue)
    #render :text => @venues
    @venues = @venues[(0..9)]
  
  end
  
  def venue_search
    @mobile = true
    @drink_id = params[:drink_id]
    @lat = params[:lat]
    @long = params[:long]
  end
  
  def create_app
  	if params[:post][:name] == ""
  		redirect_to request.referer and return
  	end
  	if params[:post][:rating] == ""
  		redirect_to request.referer and return
  	end
  	unless params[:venue]
  	  redirect_to request.referer and return
  	end
  	
    @post = Post.find_by_id(params[:drink_id])
    
    
    #assign values
    @post.name = params[:post][:name]
    @post.description = params[:post][:description]
    @post.rating = params[:post][:rating]
    #by default, set venue id to 0 (no venue)
    @post.venue_id = 0
    
    if params[:venue]
      #get venue from db or nil
      venue_in_db = Venue.find_by_foursquare_id(params[:venue])
      
      #if the venue is in the DB, use its ID, if not, get from 4sq below
      if !venue_in_db.nil?
        @post.venue_id = venue_in_db.id
      else
      	#if not, add it via 4sq
        new_venue = Venue.new
        foursquare = Foursquare::Base.new("G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT", "T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV")
        venue = foursquare.venues.find(params[:venue])
      
        new_venue.foursquare_id = venue.id
        new_venue.name = venue.name
        new_venue.phone = venue.contact['formattedPhone']
        new_venue.twitter = venue.contact['twitter']
        new_venue.address = venue.location['address']
        new_venue.lat = venue.location['lat']
        new_venue.lng = venue.location['lng']
        new_venue.postalcode = venue.location['postalCode']
        new_venue.city = venue.location['city']
        new_venue.state = venue.location['state']
        new_venue.country = venue.location['country']
        new_venue.icon = venue.icon
        #new_venue.url = venue.url
      
        new_venue.save
        
        #if the venue was pulled from 4sq, then use that ID and post the drink there
        @post.venue_id = new_venue.id
      end
    end
    
    @post.posted_by = params[:posted_by]
    @post.save
    
    if (params[:whiskey] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Whiskey"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:scotch] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Scotch"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:gin] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Gin"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:vodka] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Vodka"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:rum] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Rum"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:tequila] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Tequila"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:beer] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Beer"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:sake] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Sake"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    if (params[:wine] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Wine"
      @tag.user_id = @post.posted_by
      @tag.save
    end
    
    @mobile = true
    
    if (params[:fb] == 'post')
      user = User.find(:first, :conditions => ["id = ?", params[:posted_by]])
      
      hearts = 'hearts'
      if (@post.rating == 1)
        hearts = 'heart'
      end
   
   	  begin
   	    me = FbGraph::User.me(user.facebook_key)
   	    me.feed!(
	      :message => user.name + ' posted a drink.',
	      :picture => 'http://s3.amazonaws.com/drinkspottingsimages/posts/photos/000/000/' + @post.id.to_s + '/medium/' + @post.photo_file_name + '?' + @post.photo_file_size.to_s,
	      :link => 'http://drinkspottings.com/',
	      :name => @post.name + ' (' + @post.rating.to_s + ' ' + hearts + ')',
	      :description => @post.description
	    )
	  rescue
	    render :text => "Something is wrong with your Facebook connection to Drinkspottings. Please uninstall and reinstall Drinkspottings."
	  end
	end
  end
  

  def new
  	unless current_user
   	  flash[:notice] = "You must login first"
  	  redirect_to "/"
  	end
  	  
  
    @post = Post.new
    
    fourvenue = params[:lat] + "," + params[:long]
    
    #get nearby places from 4sq
    foursquare = Foursquare::Base.new("G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT", "T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV")
    @venues =foursquare.venues.nearby(:ll => fourvenue)
    @venues = @venues[(0..15)]
  end

  def create  
   # image = {
   # 	"name" => params[:subject],
   # 	"description" => params[:text],
   # 	"photo" => params[:attachment1]
   # }
   
   @post = Post.new(params[:post])
   
   #by default, set venue id to 0 (no venue)
   @post.venue_id = 0
    
    if params[:venue]
      #if the venue ID is already in the DB, just post the drink there
      venue_in_db = Venue.find_by_foursquare_id(params[:venue])
      
      #if the venue is in the DB, use its ID, if not, get from 4sq below
      if !venue_in_db.nil?
        @post.venue_id = venue_in_db.id
      end
      unless(Venue.find_by_foursquare_id(params[:venue]) && params[:venue])
        new_venue = Venue.new
        foursquare = Foursquare::Base.new("G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT", "T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV")
        venue = foursquare.venues.find(params[:venue])
      
        new_venue.foursquare_id = venue.id
        new_venue.name = venue.name
        new_venue.phone = venue.contact['formattedPhone']
        new_venue.twitter = venue.contact['twitter']
        new_venue.address = venue.location['address']
        new_venue.lat = venue.location['lat']
        new_venue.lng = venue.location['lng']
        new_venue.postalcode = venue.location['postalCode']
        new_venue.city = venue.location['city']
        new_venue.state = venue.location['state']
        new_venue.country = venue.location['country']
        new_venue.icon = venue.icon
        #new_venue.url = venue.url
      
        new_venue.save
        
        #if the venue was pulled from 4sq, then use that ID and post the drink there
        @post.venue_id = new_venue.id
      end
    end
    
    
    @post.posted_by = params[:posted_by]
    @post.save
    
    if (params[:whiskey] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Whiskey"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:scotch] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Scotch"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:gin] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Gin"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:vodka] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Vodka"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:rum] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Rum"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:tequila] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Tequila"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:beer] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Beer"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:sake] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Sake"
      @tag.user_id = current_user.id
      @tag.save
    end
    if (params[:wine] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Wine"
      @tag.user_id = current_user.id
      @tag.save
    end
    
    redirect_to "/"
  
  end


end
