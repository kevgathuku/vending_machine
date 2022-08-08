Rails.application.routes.draw do
  root 'site#index'

  get 'login', to: 'site#index'
  get 'signup', to: 'site#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  scope '/api' do
    resources :products
  end
end
