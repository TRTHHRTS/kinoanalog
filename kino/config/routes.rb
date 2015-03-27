Kino::Application.routes.draw do
  devise_for :users

  root 'main#index'

  get 'main', to: 'main#index'
  get 'releases', to: 'main#releases'
  get 'random_film', to: 'main#random'
  get 'details/:id', to: 'main#details'
  get 'search', to: 'main#search'
  get 'search_result', to: 'main#search_result'
  get 'new_movie', to: 'main#new_movie'
  post 'create_movie', to: 'main#create_movie'

  get 'create_review', to: 'reviews#new_review', shallow: true
  post 'create_review', to: 'reviews#create_review'
  get 'edit_review/:id', to: 'reviews#edit_review'
  patch 'edit_review/:id', to: 'reviews#update_review'
  get 'destroy_review/:id', to: 'reviews#destroy_review'
  post 'destroy_review', to: 'reviews#destroy_review'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#details'

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
