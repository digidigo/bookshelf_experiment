class User < ActiveRecord::Base
  has_many :ownerships
  has_many :books, :through => :ownerships
end
