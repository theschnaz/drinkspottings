class PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def create
  
    
    
    image = {
    	"name" => params[:subject],
    	"description" => params[:text],
    	"photo" => params[:attachment1]
    }
    
    @post = Post.new(image)
    @post.save
    
    render :text => image, :status => 200
  
  end


end
