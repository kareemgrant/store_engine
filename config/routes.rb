StoreEngine::Application.routes.draw do

  namespace :admin do
    resources :orders, :only => [:index, :show]
    resources :categories
    resources :products, :except => :destroy
    resource :dashboard, :only => :show
    put '/add_quantity_to_order/:id' => 'orders#add_quantity_to_order', :as => 'add_quantity_to_order'
    put '/decrease_quantity_from_order/:id' => 'orders#decrease_quantity_from_order', :as => 'decrease_quantity_from_order'
  end

  resources :carts
  resources :categories, :only => [:index, :show]
  resources :products, :only => [:index, :show]

  put '/add_quantity_to_cart/:id' => 'carts#add_quantity_to_cart', :as => 'add_quantity_to_cart'
  put '/decrease_quantity_from_cart/:id' => 'carts#decrease_quantity_from_cart', :as => 'decrease_quantity_from_cart'

  resources :orders

  resources :billing_address
  resources :shipping_addresses
  resources :line_items

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions


  root :to => 'store#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
