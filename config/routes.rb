Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "static_pages/help"
    get "static_pages/about"
    get "static_pages/contact"
    get "/sign-up", to: "users#new"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/users/:id/following", to: "follow_users#following", as: "user_following"
    get "/users/:id/followers", to: "follow_users#followers", as: "user_followers"

    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index destroy)
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
  end
end
