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
  
  def new_save_app
  	@saved_drink = Save.new
  	
  	user = User.find_by_uid(params[:uid])
  	
  	@saved_drink.drink_id = params[:drink_id]
  	@saved_drink.user_id = user.id
  	
  	@saved_drink.save
  	
  	render :text => "saved"
  end
  
  def delete
    @saved_drink = Save.find_by_drink_id_and_user_id(params[:drink_id], current_user.id)
    @saved_drink.delete
    
    redirect_to request.referer
  end


end
