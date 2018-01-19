Rails.application.routes.draw do
  root to: 'courses#index'

  resource :courses, only: [:show] do
    member do
      get :display_info
    end
  end
end
