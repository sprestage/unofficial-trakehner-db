Rails.application.routes.draw do

  get '/contact' => 'static#contact'
  get '/about' => 'static#about'

  resources :breeders, only: [:index, :show]

  resources :horses, only: [:index, :show] do
    member do
      get 'progeny'
    end
  end

  root to: 'home#index'

end
