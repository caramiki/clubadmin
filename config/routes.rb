Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "home#index"

  resources :clubs do
    resources :meetings do
      resources :attendances, only: [:index], controller: "meeting_attendances"
      patch "attendances", to: "meeting_attendances#update"
      put "attendances", to: "meeting_attendances#update"
    end
    resources :members do
      resources :attendances, only: [:index], controller: "member_attendances"
    end
  end
end
