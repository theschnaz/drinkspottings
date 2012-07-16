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
    
    venue = "test"
    
    unless(Venue.find_by_foursquare_id(params[:venue]))
      foursquare = Foursquare::Base.new("G24WDWF3I0VR0HEJEXYOQ4MTQ5ZW21NVEAQKKVVQDGDAFHBT", "T0SBP3DWC14VZ1ZI1ADJABS2SPQBQ4G204P1FEDVSUKQNFOV")
      venue = foursquare.venues.find(params[:venue])
    end
    
    if (params[:whiskey] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Whiskey"
      @tag.save
    end
    if (params[:scotch] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Scotch"
      @tag.save
    end
    if (params[:gin] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Gin"
      @tag.save
    end
    if (params[:vodka] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Vodka"
      @tag.save
    end
    if (params[:rum] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Rum"
      @tag.save
    end
    if (params[:tequila] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Tequila"
      @tag.save
    end
    if (params[:beer] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Beer"
      @tag.save
    end
    if (params[:sake] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Sake"
      @tag.save
    end
    if (params[:wine] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Wine"
      @tag.save
    end
    
    render :text => venue, :status => 200
  
  end


end
