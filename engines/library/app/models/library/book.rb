module Library
  class Book < ActiveRecord::Base
    validates_uniqueness_of :title
  end
end
