Rails.application.routes.draw do
  root "main#index"

  devise_for :users, path: :gurus,
                     path_names: { sign_in: :login, sign_out: :logout },
                     controllers: { sessions: 'user/sessions' }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :users_tests, only: %i(show update) do
    member do
      get :result
      post :gist
    end
  end

  get 'badges', to: 'badges#index'

  namespace :admin do
    resources :tests do
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end

      patch :update_inline, on: :member
    end

    resources :gists, only: :index

    resources :badges, except: :show
  end

  get 'feedback', to: 'feedback#index'
  post 'feedback', to: 'feedback#send_feedback'
end
