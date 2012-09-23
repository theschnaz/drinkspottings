class SavesController < ApplicationController


  def new_save
  	@saved_drink = Save.new
  	
  	@saved_drink.drink_id = 1
  	@saved_drink.user_id = 1
  	
  	@saved_drink.save
  	
  	redirect_to request.referer
  	
  end


end
