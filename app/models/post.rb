class Post < ActiveRecord::Base

  belongs_to :user
  has_many :tags

  has_attached_file :photo, 
    :styles => { :medium => "450x600#", :thumb => "100x100>" },
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
    
   def post_url
     self.photo.url(:medium)
   end
   
   def saved_by
     Save.find_by_sql ['SELECT "users".uid FROM "users", "saves" WHERE "saves".user_id = "users".id AND "saves".drink_id = \'' + self.id.to_s + '\'']
   end
   
   def tags
     Tag.find(:all, :select => "name", :conditions => ["drink_id = ?", self.id])
   end
end
