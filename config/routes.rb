ActionController::Routing::Routes.draw do |map|
  map.resources :tipo_pagos

  
  map.resources :pedido_compras , :collection => {:agregar_detalle=>:get,
                                                  :guardar =>:get
                                                 },
                                  :member =>{:show => :get}

  map.resources :compras,         :collection => {:agregar_detalle=>:get,
                                                  :guardar =>:get
                                                 },
                                  :member =>{:show => :get}

  map.resources :tipo_comprobantes

  map.resources :comprobantes

  map.resources :movimientos

  map.resources :producto_lista_precios, :collection => {:editar_x_producto => :get,
                                                         :result_x_prod => :post}
  map.resources :lista_precios

  map.resources :clientes

  map.resources :parametros

  map.resources :proveedores

  map.resources :monedas

  map.resources :estados

  map.resources :secciones

  map.resources :marcas_rubros

  map.resources :marcas_rubros

  map.resources :rubros

  map.resources :productos , :collection => {:resultado => :post,
                                             :todos => :get }

  map.resources :proveedors

  map.resources :depositos

  map.resources :unidades

  map.resources :subcategorias

  map.resources :marca_categorias

  map.resources :categorias

  map.resources :marcas


  map.resources :roles_users

  map.resources :menus_roles

  map.resources :menus, :collection => { :calculadora=>:get }
  

  map.resources :roles



  ## Agrego restful_authentication #####################
  map.logout '/logout', :controller => 'sessions', :action => 'destroy' #igual ioscor
  map.login '/login', :controller => 'sessions', :action => 'new' #igual ioscor
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users
  map.resource :session
  ########### AGREGE DE PAGINA ##########################
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  ######################################################

  map.resources :localidades

  map.resources :provincias

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  #You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "main"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
