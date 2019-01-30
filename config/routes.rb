Rails.application.routes.draw do
  devise_for :users  

  root 'posts#index' , as: 'home'
  
  #get 'posts', as: 'user_root'

  get 'users/subscription', to: 'users#subscription', as: 'users_subscription'
  post 'users/update'   => 'users#update'

  resources :posts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
