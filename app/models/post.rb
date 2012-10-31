class Post < ActiveRecord::Base

  belongs_to :user
  has_many :tags

  has_attached_file :photo, 
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
    
   def post_url
     self.photo.url(:medium)
   end
   
   def saved_list
     Save.find_by_drink_id_and_user_id(self.id, @user.id)
   end
   
   def tags
     Tag.find(:all, :select => "name", :conditions => ["drink_id = ?", self.id])
   end
end
