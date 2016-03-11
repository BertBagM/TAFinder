Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'applications#new'

  get 'applications/new', to: 'applications#new', as: 'new_application'
  post 'applications', to: 'applications#create', as: 'create_application'
  get 'applications/revoke', to: 'applications#delete', as: 'delete_application'
  post 'applications/revoke', to: 'applications#request_revoke'

  scope :admin do
    get 'login', to: 'sessions#new', as: 'login'
    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy', as: 'logout'

    get 'applications', to: 'applications#index', as: 'applications'
    get 'applications/:id/edit', to: 'applications#edit', as: 'edit_application'
    patch 'applications/:id', to: 'applications#update', as: 'update_application'
    put 'applications/:id', to: 'applications#update'
    delete 'applications/:id', to: 'applications#destroy', as: 'destroy_application'

    get 'courses', to: 'courses#index', as: 'courses'

    get 'terms', to: 'terms#index', as: 'terms'
    post 'terms', to: 'terms#create', as: 'create_term'
    patch 'terms/:id/open', to: 'terms#open', as: 'open_term'
    put 'terms/:id/open', to: 'terms#open'
    patch 'terms/:id/close', to: 'terms#close', as: 'close_term'
    put 'terms/:id/close', to: 'terms#close'
  end

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
