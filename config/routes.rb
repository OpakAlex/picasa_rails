Picasa::Application.routes.draw do

  root :to => 'welcome#index'
  match "/logout", :to => 'welcome#logout'

  match "/auth/:provider/callback", :to => "users/omniauth_callbacks#auth"

  resources :albums do
    member do
      post :create_comment
    end
  end


end
