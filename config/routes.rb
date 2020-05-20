Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  } 

  root 'home#top'
  get    'game/:id'  => 'folders#game'
  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy]

  resources :folders do
    resources :posts
    resources :likes, only: [:create, :destroy]    
  end 
  
end