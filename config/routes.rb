Lensesly::Application.routes.draw do




  get "beauty_competition/index"

  scope :controller => :content do 
    get '/opticiens' => :opticians, :as => :loli
    get '/aide' => :help, :as => :help
    get '/a-propos' => :about, :as => :aboute
    get '/contact' => :contact, :as => :contact
    get '/concours' => :concours, :as => :concours
    get '/mentions' => :mention
    get '/conditions-generales' => :conditions
    get '/ecart-pupillaire' => :pupilaire
    get '/aide' => :aide
  end

  scope :controller => :beauty_competition, :path => '/beauty' do
    post '/create' => :add_form
  end

  match '/conditions' => 'content#conditions', :as => :conditions

  #resources :newsletters
  
  post '/nws/post' => 'newsletters#create_ajax'

  mount Spree::Core::Engine, :at => '/'


  match '/adm/ajx/dl' => 'spree/products#ajax_delete_product'
  match '/adm/ajx/switch' => 'spree/products#switch_taxon'

  match '/test' => 'spree/products#test'
  match '/test_taxon/*id' => 'spree/taxons#test'

  
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
