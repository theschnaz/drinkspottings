class PostsController < ApplicationController

  def post_email
  
    @post = Post.new
    @post.save
    
    render :text => "email sent", :status => 200
  
  end


end
