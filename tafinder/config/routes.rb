Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'

  get 'applications/new', to: 'applications#new', as: 'new_application'
  post 'applications', to: 'applications#create', as: 'create_application'
  get 'applications/change', to: 'applications#change', as: 'change_application'
  post 'applications/change', to: 'applications#request_change'

  scope :admin do
    get 'login', to: 'sessions#new', as: 'login'
    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy', as: 'logout'

    get 'applications/message', to: 'application_message#edit', as: 'edit_application_message'
    patch 'applications/update_message', to: 'application_message#update', as: 'update_application_message'
    put 'applications/update_message', to: 'application_message#update'

    get 'applications', to: 'applications#index', as: 'applications'
    get 'applications/:id/edit', to: 'applications#edit', as: 'edit_application'
    patch 'applications/:id', to: 'applications#update', as: 'update_application'
    put 'applications/:id', to: 'applications#update'
    delete 'applications/:id', to: 'applications#destroy', as: 'destroy_application'

    get 'courses', to: 'courses#index', as: 'courses'
    get 'courses/new', to: 'courses#new', as: 'new_course'
    post 'courses', to: 'courses#create', as: 'create_course'
    post 'courses/import', to: 'courses#import', as: 'import_courses'
    get 'courses/:id/edit', to: 'courses#edit', as: 'edit_course'
    patch 'courses/:id', to: 'courses#update', as: 'update_course'
    put 'courses/:id', to: 'courses#update'
    delete 'courses/:id', to: 'courses#destroy', as: 'destroy_course'

    get 'courses/:course_id/sections/new', to: 'sections#new', as: 'new_section'
    post 'courses/:course_id/sections', to: 'sections#create', as: 'create_section'
    get 'courses/:course_id/sections/:id/edit', to: 'sections#edit', as: 'edit_section'
    patch 'courses/:course_id/sections/:id', to: 'sections#update', as: 'update_section'
    put 'courses/:course_id/sections/:id', to: 'sections#update'
    delete 'courses/:course_id/sections/:id', to: 'sections#destroy', as: 'destroy_section'


    get 'terms', to: 'terms#index', as: 'terms'
    post 'terms', to: 'terms#create', as: 'create_term'
    patch 'terms/:id', to: 'terms#update', as: 'update_term'
    put 'terms/:id', to: 'terms#update'
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
