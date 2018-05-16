Rails.application.routes.draw do
  get 'mypage/:id', to:'users#mypage'
  get 'index', to:'users#index'
  get 'show/:id', to:'users#show'
  get 'edit/:id', to:'users#edit'
  post 'update/:id', to:'users#update'
  get 'control/edit/:id', to:'users#edit_c'
  post 'control/update/:id', to:'users#update_c'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
