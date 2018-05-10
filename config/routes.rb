Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'

  namespace :admin do
    resources :categories
  end

  resources :posts do
    resources :replies
    member do
      post :collect
      post :uncollect
    end
  end
end
