class TagsController < ApplicationController


  def show
    #@tag = Tag.find_by
    @drink_ids = Tag.find(:all, :conditions => ["name = ?", params[:id]])
    
    render :json => @drink_ids
    
  end


end
