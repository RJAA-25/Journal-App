Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  get "/dashboard" => "pages#dashboard"
  resources :categories, except: [:index] do
    resources :tasks, except: [:index]
    patch "/tasks/:id/toggle" => "tasks#toggle", as: :task_toggle
  end
end
