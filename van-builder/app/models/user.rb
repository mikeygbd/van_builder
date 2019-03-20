class User < ActiveRecord::Base
has_many :parts
has_many :wishlist_parts
has_many :posts
has_secure_password
end
