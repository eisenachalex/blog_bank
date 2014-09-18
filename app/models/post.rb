class Post < ActiveRecord::Base
 belongs_to :user
 has_many :photos
 has_many :comments
end
 