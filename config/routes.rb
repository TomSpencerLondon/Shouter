Rails.application.routes.draw do
  root to: 'homes#show', via: :get
  resource :dashboard, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  resource :search, only: [:show, :autocomplete] do
    collection do
      get :autocomplete
    end
  end

  resources :users, only: [:index, :new, :create, :show] do
    post 'follow' => 'following_relationships#create'
    delete 'follow' => 'following_relationships#destroy'
  end
  resources :shouts, only: [:show, :destroy]
  resources :text_shouts, only: [:create]
  resources :photo_shouts, only: [:create]
  resources :hash_tags, only: [:show]
end
