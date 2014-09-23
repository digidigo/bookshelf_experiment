Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'api#index'
  
  get ':controller/:action/(/:id)'
  post ':controller/:action'

  get 'api/users/:id/books' , :controller => :api, :action => :users_books
  post 'api/users/:id/books', :controller => :api, :action => :user_gets_a_new_book
  delete 'api/users/:id/books/:book_id', :controller => :api , :action => :user_removes_a_book
  
  post 'api/users/:id/books/:book_id/tag', :controller => :api, :action => :user_tags_a_book
  post 'api/users/:id/users/:user_id/tag', :controller => :api, :action => :user_tags_a_user
  
  get 'api/users/:id/tags' , :controller => :api, :action => :tags_for_user
  get 'api/books/:id/tags' , :controller => :api, :action => :tags_for_book
  
  get 'api/books/tagged_with/:tag' , :controller => :api, :action => :books_tagged_with
  get 'api/users/tagged_with/:tag' , :controller => :api, :action => :users_tagged_with
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
