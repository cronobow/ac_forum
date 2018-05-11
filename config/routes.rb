Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'

  namespace :admin do
    root 'categories#index'
    resources :categories
    resources :users
  end

  resources :posts do
    resources :replies
    member do
      post :collect
      post :uncollect
    end
  end

  resources :users do
    member do
      get :show_comment
      get :show_collect
      get :show_draft
    end
  end
end
