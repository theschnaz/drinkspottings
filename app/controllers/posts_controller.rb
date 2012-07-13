class PostsController < ApplicationController


  def new
    @post = Post.new
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
    
    render :text => @post, :status => 200
  
  end


end
