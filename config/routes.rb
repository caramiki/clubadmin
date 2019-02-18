Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "home#index"

  resources :clubs do
    resources :attendances, only: [:create, :update, :destroy]
    resources :meetings do
      resources :attendances, only: [:index], controller: "meetings_attendances"
    end
    resources :members do
      resources :attendances, only: [:index], controller: "members_attendances"
    end
  end
end
