class PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def create
  
    @post = Post.new(params[:post])
    @post.save
    
    render :text => params[:post], :status => 200
  
  end


end
