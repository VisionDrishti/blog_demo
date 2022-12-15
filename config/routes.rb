Rails.application.routes.draw do
  devise_for :users
  get 'posts/index'
  get 'posts/show'


  resources :posts do 
    resources :comments
    resources :likes
  end   
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
