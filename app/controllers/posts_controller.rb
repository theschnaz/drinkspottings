class PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def create
  
    #@post = Post.new(params[:post])
    #@post.save
    
    image = {
    	"name" => params[:subject],
    	"description" => params[:text],
    	photo => params[:attachment1]
    }
    
    render :text => image, :status => 200
  
  end


end
