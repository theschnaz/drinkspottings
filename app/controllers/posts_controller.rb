class PostsController < ApplicationController


  def form
    @post = Post.new
  end

  def create
  
    @post = Post.new(params[:product])
    @post.save
    
    render :text => "email sent", :status => 200
  
  end


end
