Rails.application.routes.draw do

  get '/contact' => 'static#contact'
  get '/about' => 'static#about'

  resources :breeders

  resources :horses do
    member do
      get 'progeny'
    end
  end

  root to: 'home#index'

end
