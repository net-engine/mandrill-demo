MandrillDemo::Application.routes.draw do
  resources :messages
  authenticated :user do
    root to: 'messages#index', as: :messages_root
  end
  root :to => "home#index"
  devise_for :users
end
