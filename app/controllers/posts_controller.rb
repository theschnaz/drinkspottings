class PostsController < ApplicationController


  def new
    @post = Post.new
    
    #get nearby places from 4sq
    foursquare = Foursquare::Base.new("G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT", "T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV")
    @venues =foursquare.venues.nearby(:ll => "40.719193,-73.945241")
    @venues = @venues[(0..9)]
  end

  def create  
   # image = {
   # 	"name" => params[:subject],
   # 	"description" => params[:text],
   # 	"photo" => params[:attachment1]
   # }
    
    @post = Post.new(params[:post])
    @post.posted_by = params[:posted_by]
    @post.save
    
    if params[:venue]
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
      end
    end
    
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
