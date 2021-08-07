Rails.application.routes.draw do

# deviseのルート
devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}
devise_scope :customer do
    get 'login', to: 'customers/sessions#new'
    post 'login', to: 'customers/sessions#create'
    delete 'signout', to: 'customers/sessions#destroy'
    get 'sign_up', to: 'customers/registrations#new'
    post 'sign_up', to: 'customers/registrations#create'
    delete 'signout', to: 'customers/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # 会員側のルート
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    
  resources :spots do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update] do
    collection do
        get 'quit_check'
        patch 'quit'
    end
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  
  end
  
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :japan_areas, only: [:index, :edit, :update, :create]
    resources :overseas_areas, only: [:index, :edit, :update, :create]
    
  end
   
end