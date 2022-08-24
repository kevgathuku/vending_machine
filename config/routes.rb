Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'site#index'

  get 'login', to: 'site#index'
  get 'signup', to: 'site#index'

  post 'authenticate', to: 'authentication#authenticate'

  scope '/api' do
    resources :users do
      post 'deposit', to: 'deposit#deposit'
      post 'reset', to: 'deposit#reset'
    end

    resources :products
  end
end
