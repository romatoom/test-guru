Rails.application.routes.draw do
  get 'sessions/new'
  root "tests#index"

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :users_tests, only: %i(show update) do
    member do
      get :result
    end
  end

  resources :users, only: :create

  get :signup, to: "users#new"

  get :login, to: "sessions#new"

  resources :sessions, only: :create
end
