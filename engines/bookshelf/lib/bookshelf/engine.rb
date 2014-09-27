module Bookshelf
  class Engine < ::Rails::Engine
    isolate_namespace Bookshelf
    
    class << self
          def get_ownerships opts
            Bookshelf::Ownership.where(opts).all
          end

          def add_ownership *args
            Bookshelf::Ownership.create *args
          end

          def all *args
            Bookshelf::Ownership.all *args
          end
          
          def where *args
            Bookshelf::Ownership.where *args
          end
    end
  end
end
