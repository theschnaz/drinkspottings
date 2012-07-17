class TagsController < ApplicationController


  def show
    @drink_ids = Tag.find_by_name(params[:id])
    
    render :json => @drink_ids
  end


end
