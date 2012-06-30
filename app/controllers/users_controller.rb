class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @posted_and_liked_drinks = Song.find_by_sql ['SELECT "posts".* FROM "posts" WHERE ("posts".user_id = ?) ORDER BY posts.created_at DESC', @user.id]
    #posted_and_liked_drinks = Song.find_by_sql ['SELECT "songs".* FROM "songs" WHERE ("songs".user_id = ?) OR (songs.id IN (SELECT song_id from song_likes where liked_by = ?)) ORDER BY songs.created_at DESC', @user.id, @user.id]
  end


end
