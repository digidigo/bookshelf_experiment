class User < ActiveRecord::Base
  has_many :ownerships
  has_many :books, :through => :ownerships
  
  acts_as_tagger
  acts_as_taggable
end
