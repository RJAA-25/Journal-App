Rails.application.routes.draw do
  root "pages#home"
  devise_for :users, module: "users", skip: [:sessions]
  devise_scope :user do
    get "login" => "users/sessions#new", as: :new_user_session
    post "login" => "users/sessions#create", as: :user_session
    delete "logout" => "users/sessions#destroy", as: :destroy_user_session
    get "register" => "users/registrations#new", as: :register
    get ":username/profile" => "pages#profile", as: :profile
    get ":username/profile/edit" => "users/registrations#edit", as: :profile_edit
  end
  scope ":username" do
    get "dashboard" => "pages#dashboard"
    resources :categories, except: [:index] do
      resources :tasks, except: [:index]
      patch "/tasks/:id/toggle" => "tasks#toggle", as: :task_toggle
    end
  end
end
