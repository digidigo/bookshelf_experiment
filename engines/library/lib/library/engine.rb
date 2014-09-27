module Library
  class Engine < ::Rails::Engine
    isolate_namespace Library
    
    class << self
        def get_books *args
          Library::Book.find *args
        end
        
        def new_book *args
          Library::Book.create *args
        end
        
        def all_books *args
          Library::Book.all *args
        end
    end
  end
end
