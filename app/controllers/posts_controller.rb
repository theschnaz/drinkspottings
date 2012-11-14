class PostsController < ApplicationController

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
  	@error = request.referer
  
  	@mobile = true
  	@post = Post.find_by_id(params[:drink_id])
    
    fourvenue = params[:lat] + "," + params[:long]
    
    #get nearby places from 4sq
    foursquare = Foursquare::Base.new("G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT", "T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV")
    @venues =foursquare.venues.nearby(:ll => fourvenue)
    #@venues = @venues[(0..15)]
  end
  
  
  def create_app
  	if params[:post][:name]
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
      #if the venue ID is already in the DB, just post the drink there
      @post.venue_id = params[:venue]
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
    
    render :text => "Drink posted =)"
    
  
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
