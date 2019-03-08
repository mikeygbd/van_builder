class User < ActiveRecord::Base
has_many :vans
has_many :parts, through: :vans
has_secure_password

end
