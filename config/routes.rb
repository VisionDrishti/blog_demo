Rails.application.routes.draw do
  

  get 'admin', to: 'admin#index'
  get 'admin/posts'
  get 'admin/comments'
  get 'admin/users'
  get 'admin/post/:id', to: 'admin#show_post', as: 'admin_post'
resources :admin
  

  devise_for :users#, controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  # }
  # get '/u/:id', to: 'users#profile', as: 'user'
   resources :after_signup


  resources :posts do
    resources :comments
    resources :likes

  end

  get 'about', to: 'pages#about'
 
  root 'pages#home'
end