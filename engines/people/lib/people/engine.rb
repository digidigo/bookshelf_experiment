module People
  class Engine < ::Rails::Engine
    isolate_namespace People
    
    class << self
        def get_users *args
          People::User.find *args
        end
        
        def new_user *args
          People::User.create *args
        end
        
        def all_users *args
          People::User.all *args
        end
    end
  end
end
