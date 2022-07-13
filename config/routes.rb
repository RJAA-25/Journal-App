Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "pages#home"
  get "/dashboard" => "pages#dashboard"

  resources :categories do
    resources :tasks, except: [:index]
  end
end
