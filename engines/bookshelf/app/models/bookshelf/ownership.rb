module Bookshelf
  class Ownership < ActiveRecord::Base
    belongs_to :people_user, :class_name => "People::User" 
    belongs_to :library_book, :class_name => "Library::Book"
  end
end

