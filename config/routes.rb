Rails.application.routes.draw do
  devise_for :users

  root 'posts#index' , as: 'home'

  get 'users/subscription', to: 'users#subscription', as: 'users_subscription'  
  get 'users/edit/extended', to: 'users#edit_extended', as: 'users_edit_extended'
  get 'users/myposts', to: 'users#my_posts', as: 'users_my_posts'
  post 'users/update', to: 'users#update'  
  post 'users/subscribe', to: 'users#subscribe', as: 'subscribe'
  post 'users/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'

  resources :users
  resources :posts
end
