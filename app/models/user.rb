class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.name = auth["info"]["name"]
      user.username = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.facebook_key = auth["credentials"]["token"]
      user.fb_pic_square = auth["info"]["image"]
      user.fb_pic_large = auth["info"]["image"].gsub("square", "large")
      user.provider = auth["provider"]
      user.uid = auth["uid"]
    end
  end
  
end
