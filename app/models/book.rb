class Book < ActiveRecord::Base
  has_many :ownerships
  has_many :users , :through => :ownerships
  
  validates_uniqueness_of :title
  
  acts_as_tagger
  acts_as_taggable
end
