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
    if (params[:gin] == 'selected')
      @tag = Tag.new
      @tag.drink_id = @post.id
      @tag.name = "Gin"
      @tag.save
    end
    
    render :text => @post, :status => 200
  
  end


end
