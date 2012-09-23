class SavesController < ApplicationController


  def new_save
  	@saved_drink = Save.new
  	
  	@saved_drink.drink_id = params[:drink_id]
  	@saved_drink.user_id = current_user.id
  	
  	if current_user
  	  @saved_drink.save
  	end
  	
  	redirect_to request.referer
  end


end
