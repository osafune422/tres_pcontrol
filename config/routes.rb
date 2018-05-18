Rails.application.routes.draw do
  get 'mypage', to:'users#mypage'
  get 'index', to:'users#index'
  get 'show/:id', to:'users#show'
  get 'edit', to:'users#edit'
  post 'update', to:'users#update'
  get 'depa/edit/:id', to:'users#edit_depa'
  post 'depa/update/:id', to:'users#update_depa'
  post 'destroy/:id', to: 'users#destroy'
  get 'signup', to:'users#new'
  post 'create', to: 'users#create'
  get 'login', to: 'users#login_form'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
